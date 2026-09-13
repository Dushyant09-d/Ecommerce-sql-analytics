USE Ecommerce;

-- =========================================================
-- ADVANCED SQL QUESTIONS
-- =========================================================


-- Q7. Find the top 3 customers based on total spending
-- from completed orders.
-- Display customer name, total spending, and customer rank.

WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
),

ranked_customers AS (
    SELECT
        customer_name,
        total_spending,
        DENSE_RANK() OVER (
            ORDER BY total_spending DESC
        ) AS customer_rank
    FROM customer_sales
)

SELECT
    customer_name,
    total_spending,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3;


-- Q8. Find the top 2 products by revenue within
-- each product category.
-- Display category, product, revenue, and rank.

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name
),

ranked_products AS (
    SELECT
        product_name,
        category_name,
        revenue,
        DENSE_RANK() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_sales
)

SELECT
    category_name,
    product_name,
    revenue,
    product_rank
FROM ranked_products
WHERE product_rank <= 2
ORDER BY category_name, product_rank;


-- Q9. Calculate monthly revenue and compare it
-- with the previous month's revenue.
-- Consider only completed orders.

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue
FROM monthly_sales
ORDER BY month;


-- Q10. Find the most recent completed order
-- for every customer.
-- Display customer name, order ID, order date,
-- and order amount.

WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_amount
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        o.order_id,
        o.customer_id,
        o.order_date
),

ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM order_totals
)

SELECT
    c.customer_name,
    r.order_id,
    r.order_date,
    r.order_amount
FROM ranked_orders r
JOIN customers c
    ON r.customer_id = c.customer_id
WHERE r.rn = 1
ORDER BY r.order_date DESC;