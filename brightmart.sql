SELECT current_database();

CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers(first_name,last_name , email, phone)
 VALUES('Sotho', 'Man', 'sothoman49@gmail.com', '0748770900'),
 ('He is Holy', 'Jesus is King', 'jesusisking@gmail.com', '0728570800'),
 ('John', '3:16', 'helovesyou316@gmail.com', '01234567789'),
 ('Come', 'To Him', 'hebrews121@gmail.com', '0642380900'),
 ('Joshua', 'Phaka', 'phaka@gmail.com', '07456976935'),
 ('Sotho', 'Boy', 'sotho@gmail.com', '0848755738');

 SELECT 'customers' AS table_name, COUNT(*) AS record_count FROM customers
 SELECT * FROM customers


 CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (product_name,description, price, stock_quantity )
VALUES ('Sta Soft', 'Fabric softner',26.99, 36),
('Coca Cola', 'Cold beverage or cold drink',19.99, 12),
('Manjo 12.5Kg', 'Maize meal',136.99, 10),
('FunFlower 2l', 'Cooking oil',79.99, 40),
('Clover', 'Cheese',69.99, 90),
('SunBake', 'Bread',18.99, 35);

 SELECT 'products' AS table_name, COUNT(*) AS record_count FROM products
 SELECT * FROM products


 CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT chk_orders_status
        CHECK (status IN ('PENDING', 'PAID', 'SHIPPED', 'CANCELLED'))
);

SELECT * FROM orders

CREATE TABLE order_items (
    order_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uq_order_product
        UNIQUE (order_id, product_id)
);

SELECT * FROM order_items

SELECT customer_id, first_name, last_name
FROM customers
ORDER BY customer_id;

INSERT INTO orders (customer_id, status)
VALUES
    (1, 'PAID'),
    (2, 'PENDING');


SELECT order_id, customer_id, status FROM orders;
SELECT product_id, product_name, price FROM products;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 2, 249.99),
    (1, 3, 1, 99.50),
    (2, 2, 1, 899.00);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


SELECT 'customers' AS table_name, COUNT(*) AS record_count FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;

SELECT first_name, last_name, email
FROM customers;

SELECT
    product_name AS product,
    price AS selling_price
FROM products;

SELECT product_name, price
FROM products
WHERE price > 100;

SELECT product_name, price
FROM products
WHERE price < 300;

SELECT product_name, price
FROM products
WHERE stock_quantity = 15;


SELECT order_id
FROM orders
WHERE status ='PENDING' ;

SELECT product_name, price, stock_quantity
FROM products
WHERE price > 10
AND stock_quantity >= 2;

SELECT product_name
FROM products
WHERE product_name LIKE '%Manjo%';

SELECT product_name
FROM products
WHERE product_name ILIKE '%Funflower%';


SELECT order_id, status
FROM orders
WHERE status IN ('PAID', 'SHIPPED');

SELECT product_name, price
FROM products
WHERE price BETWEEN 100 AND 500;

SELECT product_name, price
FROM products
ORDER BY price DESC;


SELECT product_name, price
FROM products
ORDER BY product_name ASC;

SELECT product_name, stock_quantity, price
FROM products
ORDER BY stock_quantity ASC, price DESC;

SELECT
    orders.order_id,
    customers.first_name,
    customers.last_name,
    orders.status
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id;

	SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;



SELECT
    o.order_id,
    c.first_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


SELECT product_id, product_name, price
FROM products
WHERE product_name = 'Clover';

UPDATE products
SET price = 109.50
WHERE product_name = 'Clover';

UPDATE products
SET
    stock_quantity = 45,
    description = 'Coca Cola 2l'
WHERE product_name = 'Coca Cola';


ALTER TABLE customers
ADD COLUMN city VARCHAR(80);


ALTER TABLE customers
RENAME COLUMN phone TO phone_number;

ALTER TABLE customers
ALTER COLUMN city TYPE VARCHAR(100);


SELECT customer_id, first_name, last_name, email
FROM customers
WHERE email = 'sothoman49@gmail.com';

DELETE FROM customers
WHERE email = 'test@example.com';

BEGIN;

UPDATE products
SET price = 119.50
WHERE product_name = 'Sta Soft';

SELECT product_name, price
FROM products
WHERE product_name = 'Sta Soft';


SELECT
    SUM(quantity * unit_price) AS total_order_value
FROM order_items;


SELECT
    AVG(price) AS average_product_price
FROM products;

SELECT
    MIN(price) AS cheapest_price,
    MAX(price) AS most_expensive_price
FROM products;


SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 500;


SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;


SELECT product_name, price
FROM products
ORDER BY product_id
LIMIT 5 OFFSET 5;

ROLLBACK;

CREATE TABLE practice_notes (
    note_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    note TEXT NOT NULL
);

INSERT INTO practice_notes (note)
VALUES ('This table is only for DROP TABLE practice');


SELECT * FROM practice_notes;

DROP TABLE practice_notes;

SELECT first_name, last_name, email
FROM customers;

SELECT product_name, price
FROM products
ORDER BY price ASC;

SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity < 20;

SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;

SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;

SELECT
    AVG(price) AS average_product_price
FROM products;

SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;


SELECT
    COUNT(*) AS total_customers
FROM customers;

INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES ('Kagiso', 'Molefe', 'kagisomolefe@gmail.com', '0712345678');

