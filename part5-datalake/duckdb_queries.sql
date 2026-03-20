-- ========================================
-- DuckDB Data Lake Queries
-- Reading directly from files using schema-on-read
-- ========================================

-- Q1: List customers and total number of orders
-- Joins customers.csv with orders.json
SELECT
    c.customer_id,
    c.name,
    c.city,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('datasets/customers.csv') c
LEFT JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_orders DESC;

-- Q2: Top 3 customers by total order value
SELECT
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_order_value,
    COUNT(o.order_id) AS number_of_orders
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT
    c.customer_id,
    c.name,
    p.product_name,
    p.quantity,
    o.order_date,
    o.total_amount
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
    ON o.order_id = p.order_id
WHERE c.city = 'Bangalore'
ORDER BY o.order_date DESC;

-- Q4: Full join of all three files
-- Showing: customer name, order date, product name, and quantity
SELECT
    c.name AS customer_name,
    c.city AS customer_city,
    o.order_id,
    o.order_date,
    o.status,
    o.total_amount,
    o.num_items,
    p.product_name,
    p.quantity
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
    ON o.order_id = p.order_id
ORDER BY o.order_date DESC, c.name;
