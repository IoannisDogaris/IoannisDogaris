-- 02_data_cleaning.sql
-- Basic data quality checks and cleaned views (PostgreSQL)

CREATE OR REPLACE VIEW v_products_clean AS
SELECT
    product_id,
    TRIM(product_name) AS product_name,
    INITCAP(TRIM(category)) AS category,
    INITCAP(TRIM(brand)) AS brand,
    unit_price,
    cost
FROM products;

CREATE OR REPLACE VIEW v_customers_clean AS
SELECT
    customer_id,
    INITCAP(TRIM(first_name)) AS first_name,
    INITCAP(TRIM(last_name)) AS last_name,
    LOWER(TRIM(email)) AS email,
    UPPER(TRIM(gender)) AS gender,
    INITCAP(TRIM(city)) AS city,
    INITCAP(TRIM(region)) AS region,
    signup_date
FROM customers;

CREATE OR REPLACE VIEW v_orders_clean AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_time,
    UPPER(TRIM(order_status)) AS order_status,
    INITCAP(TRIM(order_region)) AS order_region,
    INITCAP(TRIM(order_channel)) AS order_channel,
    INITCAP(TRIM(payment_method)) AS payment_method
FROM orders;

CREATE OR REPLACE VIEW v_order_items_clean AS
SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    COALESCE(oi.discount, 0.0) AS discount,
    ROUND(oi.quantity * oi.unit_price * (1 - COALESCE(oi.discount, 0.0)), 2) AS line_total_calc,
    oi.line_total AS line_total_original
FROM order_items oi;

CREATE OR REPLACE VIEW v_order_items_quality AS
SELECT
    *,
    CASE
        WHEN ABS(line_total_calc - line_total_original) > 0.05 THEN 1
        ELSE 0
    END AS line_total_mismatch_flag
FROM v_order_items_clean;
