-- Part 1.2: Schema Design - Normalize to 3NF
-- Database: Retail Orders System
-- Student ID: bitsom_ba_25111013

-- ============================================
-- NORMALIZED SCHEMA (3NF)
-- ============================================

-- Table: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- Table: products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- Table: sales_representatives
CREATE TABLE sales_representatives (
    rep_id INT PRIMARY KEY,
    rep_name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Table: orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    rep_id INT NOT NULL,
    total_value DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id) REFERENCES sales_representatives(rep_id)
);

-- Table: order_items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- SAMPLE DATA INSERTS
-- ============================================

-- Customers (5+ rows)
INSERT INTO customers (customer_id, customer_name, city, email, phone) VALUES
(1, 'Rahul Sharma', 'Mumbai', 'rahul.sharma@email.com', '9876543210'),
(2, 'Priya Patel', 'Mumbai', 'priya.patel@email.com', '9123456789'),
(3, 'Amit Kumar', 'Delhi', 'amit.kumar@email.com', '9234567890'),
(4, 'Sneha Desai', 'Bangalore', 'sneha.desai@email.com', '9345678901'),
(5, 'Vikram Singh', 'Mumbai', 'vikram.singh@email.com', '9456789012'),
(6, 'Anjali Verma', 'Pune', 'anjali.verma@email.com', '9567890123');

-- Products (5+ rows)
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(1, 'Laptop Pro 15', 'Electronics', 85000.00),
(2, 'Wireless Mouse', 'Electronics', 1200.00),
(3, 'Office Chair', 'Furniture', 15000.00),
(4, 'Desk Lamp LED', 'Electronics', 2500.00),
(5, 'Coffee Maker', 'Appliances', 8000.00),
(6, 'Bluetooth Speaker', 'Electronics', 3500.00);

-- Sales Representatives (5+ rows)
INSERT INTO sales_representatives (rep_id, rep_name, region, email, phone) VALUES
(1, 'Rajesh Gupta', 'Mumbai', 'rajesh.g@sales.com', '8765432109'),
(2, 'Meera Reddy', 'Delhi', 'meera.r@sales.com', '8654321098'),
(3, 'Suresh Nair', 'Bangalore', 'suresh.n@sales.com', '8543210987'),
(4, 'Kavita Joshi', 'Mumbai', 'kavita.j@sales.com', '8432109876'),
(5, 'Anil Kapoor', 'Pune', 'anil.k@sales.com', '8321098765');

-- Orders (10+ rows)
INSERT INTO orders (order_id, order_date, customer_id, rep_id, total_value) VALUES
(1, '2024-01-15', 1, 1, 90000.00),
(2, '2024-02-10', 2, 1, 4700.00),
(3, '2024-02-20', 3, 2, 17500.00),
(4, '2024-03-05', 1, 1, 12000.00),
(5, '2024-03-15', 4, 3, 85000.00),
(6, '2024-04-01', 5, 4, 27500.00),
(7, '2024-04-10', 2, 1, 5000.00),
(8, '2024-05-01', 6, 5, 3500.00),
(9, '2024-05-15', 3, 2, 8000.00),
(10, '2024-06-01', 1, 1, 15000.00),
(11, '2024-06-15', 4, 3, 100000.00);

-- Order Items (15+ rows)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 1, 85000.00, 85000.00),
(2, 1, 2, 5, 1200.00, 6000.00),
(3, 2, 4, 1, 2500.00, 2500.00),
(4, 2, 6, 2, 3500.00, 7000.00),
(5, 3, 3, 1, 15000.00, 15000.00),
(6, 3, 5, 1, 8000.00, 8000.00),
(7, 4, 2, 10, 1200.00, 12000.00),
(8, 5, 1, 1, 85000.00, 85000.00),
(9, 6, 1, 1, 85000.00, 85000.00),
(10, 6, 4, 2, 2500.00, 5000.00),
(11, 7, 3, 1, 15000.00, 15000.00),
(12, 7, 4, 1, 2500.00, 2500.00),
(13, 8, 6, 1, 3500.00, 3500.00),
(14, 9, 5, 1, 8000.00, 8000.00),
(15, 10, 2, 5, 1200.00, 6000.00),
(16, 10, 4, 2, 2500.00, 5000.00),
(17, 10, 6, 1, 3500.00, 3500.00),
(18, 11, 1, 1, 85000.00, 85000.00),
(19, 11, 3, 1, 15000.00, 15000.00);
