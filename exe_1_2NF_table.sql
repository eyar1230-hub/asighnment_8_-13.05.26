
--1. Identify which columns have partial dependencies and what they depend on.
-- answer:
	-- customer_name
	-- product_name
	-- unit_price

--2. Design a 2NF-compliant schema: customers, products, orders, order_items.
-- anwer:
	-- table 1: customers (id,name)
	-- TABLE 2: produts (id, product_name, price)
	-- table 3: orders (order_id,customer_id)
	-- table 4: orders_items (order_id, product_id, qty)
-- 	https://dbdiagram.io/d/exe_1_2NF_table-6a098df4697f99c167920161
	
--3. Write CREATE TABLE statements for all four tables.
CREATE TABLE customers(
	id 		INTEGER PRIMARY KEY AUTOINCREMENT,
	name 	TEXT NOT NULL
	);
	
CREATE TABLE products(
	id 		INTEGER PRIMARY KEY,
	name 	TEXT NOT NULL,
	price 	REAL NOT NULL
	);
	
CREATE TABLE orders(
	id 			INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(id)
		on DELETE CASCADE

	);
	
CREATE TABLE orders_items(
	order_id 	INTEGER,
	product_id 	INTEGER NOT NULL,
	qty 		INTEGER NOT NULL,
	PRIMARY KEY (order_id, product_id),
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
		on DELETE CASCADE

	);
	
--4. Insert the data from the original table into your 2NF schema.
INSERT INTO customers (name)
	VALUES ('Alice'), ('Bob')
	;

INSERT INTO products (id, name, price)
	VALUES  (42, 'Mouse', 29.99), (77, 'Keyboard', 49.99)
	;

INSERT INTO orders (id, customer_id)
	VALUES (1001, 1), (1002, 2)
	;

INSERT INTO orders_items (order_id,product_id,qty)
	VALUES (1001, 77, 2), (1001, 42, 1), (1002, 77, 1)
	;

	
--5. Write a query to reproduce the original table's data using JOINs.
SELECT
	oi.order_id as Order_ID,
	oi.product_id as Product_ID,
	oi.qty as QTY,
	c.name AS Customer_Name,
	p.name as Product_Name,
	p.price as Unit_Price
FROM orders_items oi
JOIN products p  ON oi.product_id = p.id
JOIN orders o    ON oi.order_id = o.id
JOIN customers c ON o.customer_id = c.id
;


--6. Bonus: rename "Keyboard" to "Mechanical Keyboard" — in the bad table vs the 2NF table. How many rows changed in each?
UPDATE products
set name = 'Mechanical Keyboard'
WHERE id = 77
;
--2 rows have changed in the bad table (or more if there are more roes 
	--how ever in the 2NF table we see a change in only one table at one row no matter how many rows we have

