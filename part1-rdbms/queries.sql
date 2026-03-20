-- Part 1.3: SQL Queries
-- Database: Retail Orders System
-- Student ID: bitsom_ba_25111013

-- ============================================
-- Q1: List all customers from Mumbai along with their total order value
-- ============================================
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    SUM(o.total_value) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE LOWER(c.city) = 'mumbai'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_order_value DESC;

-- ============================================
-- Q2: Find the top 3 products by total quantity sold
-- ============================================
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- ============================================
-- Q3: List all sales representatives and the number of unique customers they have handled
-- ============================================
SELECT 
    s.rep_id,
    s.rep_name,
    s.region,
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM sales_representatives s
LEFT JOIN orders o ON s.rep_id = o.rep_id
GROUP BY s.rep_id, s.rep_name, s.region
ORDER BY unique_customers_handled DESC;

-- ============================================
-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- ============================================
SELECT 
    o.order_id,
    o.order_date,
    c.customer_name,
    s.rep_name,
    o.total_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN sales_representatives s ON o.rep_id = s.rep_id
WHERE o.total_value > 10000
ORDER BY o.total_value DESC;

-- ============================================
-- Q5: Identify any products that have never been ordered
-- ============================================
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price
FROM products p
WHERE p.product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM order_items
)
ORDER BY p.product_id;
