-- 05_business_questions.sql
-- Business questions (PostgreSQL)

-- 1. Top 5 products by revenue
SELECT
    product_id,
    product_name,
    category,
    SUM(line_total) AS total_revenue,
    SUM(quantity) AS total_qty
FROM v_sales_fact
GROUP BY product_id, product_name, category
ORDER BY total_revenue DESC
LIMIT 5;

-- 2. Revenue by month and region
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS year_month,
    order_region,
    SUM(line_total) AS total_revenue,
    COUNT(DISTINCT order_id) AS orders_count
FROM v_sales_fact
GROUP BY TO_CHAR(order_date, 'YYYY-MM'), order_region
ORDER BY year_month, order_region;

-- 3. Simple customer segmentation by total revenue
WITH customer_spend AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        SUM(line_total) AS total_revenue,
        COUNT(DISTINCT order_id) AS orders_count
    FROM v_sales_fact
    GROUP BY customer_id, first_name, last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_revenue,
    orders_count,
    CASE
        WHEN total_revenue >= 60 THEN 'High'
        WHEN total_revenue >= 30 THEN 'Medium'
        ELSE 'Low'
    END AS segment
FROM customer_spend
ORDER BY total_revenue DESC;

-- 4. Repeat purchase behavior
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS orders_count,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date
    FROM v_sales_fact
    GROUP BY customer_id
)
SELECT
    customer_id,
    orders_count,
    first_order_date,
    last_order_date
FROM customer_orders
WHERE orders_count > 1
ORDER BY orders_count DESC;

-- 5. Basket size analysis
WITH basket AS (
    SELECT
        order_id,
        COUNT(*) AS items_count,
        SUM(quantity) AS units_count,
        SUM(line_total) AS basket_value
    FROM v_sales_fact
    GROUP BY order_id
)
SELECT
    AVG(items_count) AS avg_items_per_order,
    AVG(units_count) AS avg_units_per_order,
    ROUND(AVG(basket_value), 2) AS avg_basket_value
FROM basket;

-- 6. Basket size by channel
WITH basket AS (
    SELECT
        order_id,
        order_channel,
        COUNT(*) AS items_count,
        SUM(line_total) AS basket_value
    FROM v_sales_fact
    GROUP BY order_id, order_channel
)
SELECT
    order_channel,
    ROUND(AVG(items_count), 2) AS avg_items_per_order,
    ROUND(AVG(basket_value), 2) AS avg_basket_value
FROM basket
GROUP BY order_channel;
