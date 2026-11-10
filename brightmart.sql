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
