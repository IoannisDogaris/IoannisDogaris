-- 03_joins_aggregations.sql
-- Core joins and basic aggregations (PostgreSQL)

CREATE OR REPLACE VIEW v_sales_fact AS
SELECT
    o.order_id,
    o.order_date,
    o.order_time,
    o.order_region,
    o.order_channel,
    o.order_status,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.region AS customer_region,
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    oi.quantity,
    oi.unit_price,
    oi.discount,
    oi.line_total
FROM v_orders_clean o
JOIN v_customers_clean c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN v_products_clean p ON oi.product_id = p.product_id
WHERE o.order_status = 'COMPLETED';

CREATE OR REPLACE VIEW v_daily_revenue AS
SELECT
    order_date,
    SUM(line_total) AS daily_revenue,
    COUNT(DISTINCT order_id) AS orders_count
FROM v_sales_fact
GROUP BY order_date
ORDER BY order_date;

CREATE OR REPLACE VIEW v_revenue_by_product AS
SELECT
    product_id,
    product_name,
    category,
    SUM(quantity) AS total_qty,
    SUM(line_total) AS total_revenue
FROM v_sales_fact
GROUP BY product_id, product_name, category
ORDER BY total_revenue DESC;

CREATE OR REPLACE VIEW v_revenue_by_region_channel AS
SELECT
    order_region,
    order_channel,
    SUM(line_total) AS total_revenue,
    COUNT(DISTINCT order_id) AS orders_count
FROM v_sales_fact
GROUP BY order_region, order_channel
ORDER BY total_revenue DESC;
