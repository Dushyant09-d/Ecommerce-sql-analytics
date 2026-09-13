CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);
INSERT INTO customers
(customer_id, customer_name, email, city, state, signup_date)
VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', 'Bhopal', 'Madhya Pradesh', '2025-01-10'),
(2, 'Priya Singh', 'priya@gmail.com', 'Indore', 'Madhya Pradesh', '2025-02-15'),
(3, 'Rahul Verma', 'rahul@gmail.com', 'Delhi', 'Delhi', '2025-03-20'),
(4, 'Sneha Patel', 'sneha@gmail.com', 'Ahmedabad', 'Gujarat', '2025-04-12'),
(5, 'Arjun Mehta', 'arjun@gmail.com', 'Mumbai', 'Maharashtra', '2025-05-18'),
(6, 'Neha Gupta', 'neha@gmail.com', 'Pune', 'Maharashtra', '2025-06-22'),
(7, 'Rohan Joshi', 'rohan@gmail.com', 'Jaipur', 'Rajasthan', '2025-07-05'),
(8, 'Ananya Rao', 'ananya@gmail.com', 'Bangalore', 'Karnataka', '2025-07-19'),
(9, 'Vikram Yadav', 'vikram@gmail.com', 'Lucknow', 'Uttar Pradesh', '2025-08-11'),
(10, 'Kavya Nair', 'kavya@gmail.com', 'Kochi', 'Kerala', '2025-09-25'),
(11, 'Aditya Kumar', 'aditya@gmail.com', 'Bhopal', 'Madhya Pradesh', '2025-10-02'),
(12, 'Meera Shah', 'meera@gmail.com', 'Surat', 'Gujarat', '2025-10-15');

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories
(category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Fashion'),
(4, 'Home'),
(5, 'Sports');


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

INSERT INTO products
(product_id, product_name, category_id, price, stock)
VALUES
(101, 'Laptop', 1, 65000, 10),
(102, 'Smartphone', 1, 30000, 20),
(103, 'Headphones', 1, 3000, 50),
(104, 'Keyboard', 2, 2000, 40),
(105, 'Mouse', 2, 1200, 60),
(106, 'Monitor', 1, 18000, 15),
(107, 'Backpack', 3, 2500, 30),
(108, 'Running Shoes', 3, 4500, 25),
(109, 'Smart Watch', 1, 8000, 18),
(110, 'Desk Lamp', 4, 1500, 35),
(111, 'Yoga Mat', 5, 1800, 40),
(112, 'Football', 5, 1200, 25),
(113, 'Office Chair', 4, 12000, 12),
(114, 'USB Hub', 2, 1500, 45),
(115, 'Bluetooth Speaker', 1, 5500, 22);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, '2025-08-01', 'Completed'),
(1002, 2, '2025-08-03', 'Completed'),
(1003, 3, '2025-08-05', 'Completed'),
(1004, 1, '2025-08-08', 'Completed'),
(1005, 4, '2025-08-10', 'Cancelled'),
(1006, 5, '2025-08-12', 'Completed'),
(1007, 6, '2025-08-15', 'Completed'),
(1008, 2, '2025-08-18', 'Completed'),
(1009, 7, '2025-08-20', 'Completed'),
(1010, 8, '2025-08-22', 'Completed'),
(1011, 3, '2025-08-25', 'Completed'),
(1012, 5, '2025-08-28', 'Completed'),
(1013, 9, '2025-09-01', 'Completed'),
(1014, 10, '2025-09-03', 'Completed'),
(1015, 1, '2025-09-05', 'Completed'),
(1016, 11, '2025-09-08', 'Completed'),
(1017, 12, '2025-09-12', 'Completed'),
(1018, 4, '2025-09-15', 'Completed'),
(1019, 6, '2025-09-18', 'Completed'),
(1020, 8, '2025-09-22', 'Completed');

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 65000),
(2, 1001, 103, 2, 3000),
(3, 1002, 102, 1, 30000),
(4, 1002, 105, 2, 1200),
(5, 1003, 106, 1, 18000),
(6, 1003, 104, 1, 2000),
(7, 1004, 109, 1, 8000),
(8, 1004, 105, 1, 1200),
(9, 1005, 108, 2, 4500),
(10, 1006, 101, 1, 65000),
(11, 1006, 104, 2, 2000),
(12, 1007, 103, 3, 3000),
(13, 1007, 107, 1, 2500),
(14, 1008, 102, 1, 30000),
(15, 1008, 109, 1, 8000),
(16, 1009, 108, 1, 4500),
(17, 1009, 107, 2, 2500),
(18, 1010, 101, 1, 65000),
(19, 1011, 106, 2, 18000),
(20, 1011, 103, 1, 3000),
(21, 1012, 102, 2, 30000),
(22, 1013, 109, 1, 8000),
(23, 1013, 105, 2, 1200),
(24, 1014, 110, 2, 1500),
(25, 1014, 107, 1, 2500),
(26, 1015, 101, 1, 65000),
(27, 1015, 106, 1, 18000),
(28, 1016, 111, 2, 1800),
(29, 1016, 112, 1, 1200),
(30, 1017, 113, 1, 12000),
(31, 1017, 110, 1, 1500),
(32, 1018, 108, 1, 4500),
(33, 1018, 111, 2, 1800),
(34, 1019, 102, 1, 30000),
(35, 1019, 115, 2, 5500),
(36, 1020, 109, 1, 8000),
(37, 1020, 114, 2, 1500),
(38, 1020, 105, 1, 1200),
(39, 1017, 115, 1, 5500),
(40, 1016, 114, 1, 1500);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO payments
(payment_id, order_id, payment_method, payment_status, payment_date)
VALUES
(501, 1001, 'UPI', 'Successful', '2025-08-01'),
(502, 1002, 'Credit Card', 'Successful', '2025-08-03'),
(503, 1003, 'Debit Card', 'Successful', '2025-08-05'),
(504, 1004, 'UPI', 'Successful', '2025-08-08'),
(505, 1005, 'Credit Card', 'Failed', '2025-08-10'),
(506, 1006, 'UPI', 'Successful', '2025-08-12'),
(507, 1007, 'Cash on Delivery', 'Successful', '2025-08-15'),
(508, 1008, 'Credit Card', 'Successful', '2025-08-18'),
(509, 1009, 'UPI', 'Successful', '2025-08-20'),
(510, 1010, 'Debit Card', 'Successful', '2025-08-22'),
(511, 1011, 'UPI', 'Successful', '2025-08-25'),
(512, 1012, 'Credit Card', 'Successful', '2025-08-28'),
(513, 1013, 'UPI', 'Successful', '2025-09-01'),
(514, 1014, 'Cash on Delivery', 'Successful', '2025-09-03'),
(515, 1015, 'Credit Card', 'Successful', '2025-09-05'),
(516, 1016, 'UPI', 'Successful', '2025-09-08'),
(517, 1017, 'Debit Card', 'Successful', '2025-09-12'),
(518, 1018, 'UPI', 'Successful', '2025-09-15'),
(519, 1019, 'Credit Card', 'Successful', '2025-09-18'),
(520, 1020, 'UPI', 'Successful', '2025-09-22');


