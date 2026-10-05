-- ============================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- ECOMMERCE DATABASE
-- ============================================


-- ============================================
-- 1. DATABASE SETUP
-- ============================================

CREATE DATABASE ecommerce;
USE ecommerce;


-- ============================================
-- 2. CREATE TABLES
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================
-- 3. INSERT CUSTOMER DATA
-- ============================================

INSERT INTO customers VALUES
(1, 'Rahul', 'Bengaluru', 'India'),
(2, 'Priya', 'Chennai', 'India'),
(3, 'Arjun', 'Hyderabad', 'India'),
(4, 'Sneha', 'Mumbai', 'India'),
(5, 'Kiran', 'Delhi', 'India'),
(6, 'Ananya', 'Pune', 'India'),
(7, 'Rohan', 'Bengaluru', 'India'),
(8, 'Meera', 'Kochi', 'India');


-- ============================================
-- 4. INSERT PRODUCT DATA
-- ============================================

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 25000.00),
(103, 'Headphones', 'Electronics', 3000.00),
(104, 'Office Chair', 'Furniture', 8000.00),
(105, 'Desk', 'Furniture', 12000.00),
(106, 'Backpack', 'Accessories', 2000.00),
(107, 'Keyboard', 'Electronics', 2500.00),
(108, 'Mouse', 'Electronics', 1200.00);


-- ============================================
-- 5. INSERT ORDER DATA
-- ============================================

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2026-01-05'),
(1002, 2, 102, 2, '2026-01-10'),
(1003, 3, 103, 3, '2026-01-15'),
(1004, 4, 104, 1, '2026-02-02'),
(1005, 5, 105, 2, '2026-02-08'),
(1006, 6, 106, 4, '2026-02-15'),
(1007, 7, 107, 2, '2026-03-01'),
(1008, 8, 108, 3, '2026-03-12'),
(1009, 1, 102, 1, '2026-03-20'),
(1010, 2, 101, 1, '2026-04-05'),
(1011, 3, 104, 2, '2026-04-18'),
(1012, 4, 103, 2, '2026-05-03'),
(1013, 5, 106, 5, '2026-05-15'),
(1014, 6, 105, 1, '2026-06-01'),
(1015, 7, 108, 4, '2026-06-20');


-- ============================================
-- 6. BASIC SELECT
-- ============================================

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;


-- ============================================
-- 7. WHERE
-- ============================================

SELECT *
FROM products
WHERE category = 'Electronics';


-- ============================================
-- 8. ORDER BY
-- SCREENSHOT 1: 01_product_sort.png
-- ============================================

SELECT *
FROM products
ORDER BY price DESC;


-- ============================================
-- 9. GROUP BY + SUM
-- SCREENSHOT 2: 02_category_revenue.png
-- ============================================

SELECT
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category;


-- ============================================
-- 10. AVG
-- SCREENSHOT 3: 03_customer_revenue.png
-- ============================================

SELECT
    c.customer_id,
    c.customer_name,
    AVG(o.quantity * p.price) AS average_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY average_revenue DESC;


-- ============================================
-- 11. INNER JOIN
-- SCREENSHOT 4: 04_inner_join.png
-- ============================================

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN products p
    ON o.product_id = p.product_id;


-- ============================================
-- 12. LEFT JOIN
-- ============================================

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;


-- ============================================
-- 13. SUBQUERY
-- SCREENSHOT 5: 05_subquery.png
-- ============================================

SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


-- ============================================
-- 14. VIEW
-- ============================================

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity * p.price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;

SELECT * FROM customer_order_summary;


-- ============================================
-- 15. INDEX
-- ============================================

CREATE INDEX idx_order_date
ON orders(order_date);

SHOW INDEX FROM orders;


-- ============================================
-- 16. HAVING
-- SCREENSHOT 6: 06_having_revenue.png
-- ============================================

SELECT
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.quantity * p.price) > 20000;


-- ============================================
-- END OF TASK 3
-- ============================================