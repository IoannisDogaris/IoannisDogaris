-- 04_window_functions.sql
-- Window functions: LAG, RANK, moving averages (PostgreSQL)

CREATE OR REPLACE VIEW v_daily_revenue_window AS
SELECT
    order_date,
    daily_revenue,
    LAG(daily_revenue) OVER (ORDER BY order_date) AS prev_day_revenue,
    daily_revenue - LAG(daily_revenue) OVER (ORDER BY order_date) AS revenue_change,
    ROUND(
        100.0 * (daily_revenue - LAG(daily_revenue) OVER (ORDER BY order_date))
        / NULLIF(LAG(daily_revenue) OVER (ORDER BY order_date), 0),
        2
    ) AS revenue_change_pct
FROM v_daily_revenue;

CREATE OR REPLACE VIEW v_daily_revenue_mavg AS
SELECT
    order_date,
    daily_revenue,
    ROUND(
        AVG(daily_revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS revenue_ma_3d
FROM v_daily_revenue;

CREATE OR REPLACE VIEW v_product_rank_in_category AS
SELECT
    category,
    product_id,
    product_name,
    total_revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS revenue_rank_in_category
FROM v_revenue_by_product;

CREATE OR REPLACE VIEW v_customer_ltv AS
SELECT
    customer_id,
    first_name,
    last_name,
    SUM(line_total) AS total_revenue,
    COUNT(DISTINCT order_id) AS orders_count,
    RANK() OVER (ORDER BY SUM(line_total) DESC) AS revenue_rank
FROM v_sales_fact
GROUP BY customer_id, first_name, last_name;
