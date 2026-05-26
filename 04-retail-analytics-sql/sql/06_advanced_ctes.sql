-- 06_advanced_ctes.sql
-- Advanced CTEs (PostgreSQL)

-- 1. Signup cohort vs first purchase
WITH customer_first_order AS (
    SELECT
        c.customer_id,
        c.signup_date,
        MIN(o.order_date) AS first_order_date
    FROM v_customers_clean c
    JOIN v_orders_clean o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.signup_date
)
SELECT
    customer_id,
    signup_date,
    first_order_date,
    (first_order_date - signup_date) AS days_to_first_order
FROM customer_first_order
ORDER BY days_to_first_order;

-- 2. RFM-style scoring
WITH customer_metrics AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order_date,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(line_total) AS monetary
    FROM v_sales_fact
    GROUP BY customer_id
),
rfm_raw AS (
    SELECT
        customer_id,
        last_order_date,
        frequency,
        monetary,
        (SELECT MAX(order_date) FROM v_sales_fact) - last_order_date AS recency_days
    FROM customer_metrics
)
SELECT
    customer_id,
    recency_days,
    frequency,
    monetary,
    CASE WHEN recency_days <= 1 THEN 3 WHEN recency_days <= 3 THEN 2 ELSE 1 END AS recency_score,
    CASE WHEN frequency >= 3 THEN 3 WHEN frequency = 2 THEN 2 ELSE 1 END AS frequency_score,
    CASE WHEN monetary >= 60 THEN 3 WHEN monetary >= 30 THEN 2 ELSE 1 END AS monetary_score
FROM rfm_raw
ORDER BY monetary DESC;

-- 3. Weekday/hour heatmap prep
SELECT
    TO_CHAR(order_date, 'DY') AS weekday,
    EXTRACT(HOUR FROM order_time) AS hour_of_day,
    SUM(line_total) AS total_revenue,
    COUNT(DISTINCT order_id) AS orders_count
FROM v_sales_fact
GROUP BY TO_CHAR(order_date, 'DY'), EXTRACT(HOUR FROM order_time)
ORDER BY weekday, hour_of_day;
