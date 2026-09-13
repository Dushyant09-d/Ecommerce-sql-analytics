USE Ecommerce;

-- =========================================================
-- EASY SQL QUESTIONS
-- =========================================================


-- Q1. Display the customer name, city, and state
-- of customers who are from Madhya Pradesh.

SELECT
    customer_name,
    city,
    state
FROM customers
WHERE state = 'Madhya Pradesh';


-- Q2. Display the 5 most expensive products.
-- Show product name, category ID, and price.

SELECT
    product_name,
    category_id,
    price
FROM products
ORDER BY price DESC
LIMIT 5;