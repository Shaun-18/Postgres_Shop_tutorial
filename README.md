# Postgres_Shop_tutorial
Kagiso Shaun Molefe, 10/11/2026

# PostgreSQL Shop Tutorial – SQL Concepts

## 1. What is a primary key?

A primary key is a column (or combination of columns) that uniquely identifies each record in a database table. It cannot contain duplicate or NULL values.

**Example:** In the `customers` table, `customer_id` is the primary key. Each customer receives a unique ID.

```sql
customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
```

## 2. What is a foreign key?

A foreign key is a column that references the primary key of another table. It establishes a relationship between two tables and helps maintain referential integrity.

**Example:** In the `orders` table, `customer_id` references `customer_id` in the `customers` table. This ensures that an order belongs to an existing customer.

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
```

## 3. Why do we use joins?

We use JOINs to retrieve related information from multiple database tables using common columns.

JOINs help us avoid unnecessary duplication of data and allow us to combine information from related tables.

**Example:** We can join the `orders` and `customers` tables to display each order alongside the customer's name and order status.

```sql
SELECT
    c.first_name,
    c.last_name,
    o.status
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

## 4. What is the difference between WHERE and HAVING?

`WHERE` and `HAVING` are both used to filter data, but they work at different stages of a query.

- **WHERE:** Filters individual rows before grouping and aggregation.
- **HAVING:** Filters grouped results after `GROUP BY` and aggregation.

**Example using WHERE:**

```sql
SELECT product_name, price
FROM products
WHERE price > 100;
```

This displays products with prices greater than 100.

**Example using HAVING:**

```sql
SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 100;
```

This displays orders whose total value is greater than 100.

## 5. What is the difference between UPDATE and ALTER TABLE?

`UPDATE` and `ALTER TABLE` are used for different database operations.

- **UPDATE:** Changes existing data inside a table.
- **ALTER TABLE:** Changes the structure or definition of an existing table.

**Example using UPDATE:**

```sql
UPDATE products
SET price = 109.50
WHERE product_name = 'Clover';
```

This changes the price of Clover.

**Example using ALTER TABLE:**

```sql
ALTER TABLE customers
ADD COLUMN city VARCHAR(80);
```

This adds a new column called `city` to the customers table.

## 6. Why should you be careful when using DELETE?

You should be careful when using `DELETE` because it permanently removes selected records from a table when the transaction is committed.

If you forget the `WHERE` clause, you could accidentally delete every record in the table.

**Example:**

```sql
DELETE FROM customers
WHERE customer_id = 5;
```

This deletes the customer with ID 5.

Always verify your conditions before executing a DELETE statement.

## 7. What is the difference between DELETE and DROP TABLE?

Both commands remove data, but they operate differently.

- **DELETE:** Removes records from a table while keeping the table structure intact.
- **DROP TABLE:** Removes the entire table, including its structure, data, constraints and indexes.

**Example using DELETE:**

```sql
DELETE FROM customers
WHERE customer_id = 5;
```

**Example using DROP TABLE:**

```sql
DROP TABLE customers;
```

The first removes a specific customer, while the second removes the entire customers table.

## 8. Why is ORDER BY useful with LIMIT?

`ORDER BY` sorts records according to a specified column, while `LIMIT` restricts the number of records returned.

Using them together allows us to retrieve specific records based on their ranking or order.

**Example:**

```sql
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;
```

This retrieves the five most expensive products.

Without `ORDER BY`, the database does not guarantee which five records will be returned.

## 9. When would you use SUM() instead of AVG()?

We use `SUM()` when we want to calculate the total value of numerical data.

We use `AVG()` when we want to calculate the average or mean value of numerical data.

**Example using SUM():**

```sql
SELECT SUM(price) AS total_product_value
FROM products;
```

This calculates the sum of all product prices.

**Example using AVG():**

```sql
SELECT AVG(price) AS average_product_price
FROM products;
```

This calculates the average price of all products.

In a shop database, `SUM()` can calculate total sales, while `AVG()` can calculate the average selling price.

## 10. Why is it important to use constraints in a relational database?

Constraints are rules applied to database columns and tables to maintain data accuracy, consistency and integrity.

They prevent invalid or incorrect information from being inserted into the database.

Common constraints include:

- **PRIMARY KEY:** Ensures each record has a unique identifier.
- **FOREIGN KEY:** Maintains relationships between tables.
- **NOT NULL:** Prevents a column from accepting NULL values.
- **UNIQUE:** Prevents duplicate values in a column.
- **CHECK:** Ensures values satisfy a specified condition.
- **DEFAULT:** Provides a default value when no value is supplied.

**Example:**

sql
price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)


This ensures that a product must have a price and that the price cannot be negative.

Constraints are important because they protect the database against invalid data and help maintain reliable relationships between tables.

---

## Conclusion

Through this PostgreSQL Shop Tutorial, I have learned fundamental SQL concepts, including database creation, data manipulation, filtering, sorting, joins, aggregate functions, transactions and database constraints.

These concepts provide a foundation for developing database-driven applications and integrating PostgreSQL with backend technologies such as Java and Spring Boot.
