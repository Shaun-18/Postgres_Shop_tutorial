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

