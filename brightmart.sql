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

 