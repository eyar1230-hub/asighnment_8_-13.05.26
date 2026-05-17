--1. Check: is this table in 1NF? Explain why.
	-- yes because there are no repeating column groups or multiple values in a cell and al rows has UNIQUE pk's

--2. Check: is this table in 2NF? Explain why (single-column PK).
	--no because there's no composite pk.

--3. Identify all transitive dependencies in the table.

	-- author - (author_name, author_id)
	-- publisher - (publisher_id, publisher_name, publisher_city)
	-- book - (isbn, title)
		-- 978-1	SQL Mastery	A1	Jane Doe	P1	TechPress	New York
		-- 978-2	Python Pro	A2	John Smith	P1	TechPress	New York
		-- 978-3	Data Viz	A1	Jane Doe	P2	DataBooks	Paris


--4. Design a 3NF schema with tables: books, authors, publishers.

	-- author - (id, name)
	-- publisher - (id, name, city)
	-- books - (author_id(FK), publisher_id(FK), isbn, title)
	-- dbdiagram.io:
		-- https://dbdiagram.io/d/6a09bac3697f99c167930cfe

--5. Write CREATE TABLE statements for all three tables with proper PKs and FKs.
--author - (id, name)
CREATE TABLE author(
  id 	TEXT PRIMARY KEY,
  name 	TEXT NOT NULL
);

-- publisher - (id, name, city)
CREATE TABLE publisher(
  id 	TEXT PRIMARY KEY,
  name 	text not null,
  city 	text not null
);

--books - (author_id(FK), publisher_id(FK), isbn, title)
CREATE TABLE books(
  author_id 	TEXT,
  publisher_id 	TEXT,
  isbn 			TEXT	NOT NULL CHECK (isbn > 0),
  title 		TEXT NOT NULL,
  PRIMARY KEY (author_id,publisher_id),
  FOREIGN KEY (author_id) REFERENCES author(id),
  FOREIGN KEY (publisher_id) REFERENCES publisher(id)
  on DELETE CASCADE
);

--6. Insert the original data into the normalized tables.


INSERT INTO author (id,name)
	VALUES
	('A1', 'Jane Doe'),
	('A2', 'John Smith')
;

INSERT INTO publisher (id,name,city)
	VALUES
	('P1', 'TechPress', 'New York'),
	('P2', 'DataBooks', 'Paris')
	;
	
INSERT INTO books (author_id,publisher_id,isbn,title)
	VALUES
	('A1', 'P1', '978-1',	'SQL Mastery'),
	('A2', 'P1', '978-2', 'Python Pro'),
	('A1', 'P2', '978-3', 'Data Viz')
;
	
--7. Write a query to reproduce all original columns using JOINs.
SELECT 
	b.isbn				as isbn,
	b.title				as title,
	b.author_id			as author_id,
	a.name				as author_name,
	b.publisher_id		as publisher_id,
	p.name				as publisher_name,
	p.city 				as publisher_city
FROM books b
JOIN author a on b.author_id = a.id
JOIN publisher p on b.publisher_id = p.id
;

--8. Bonus: Change Jane Doe's name to "Jane Doe-Smith" — how many rows change in the 3NF vs original schema?
UPDATE author
set name = 'Jane Doe-Smith'
WHERE id = 'A1'
;
--2 rows have changed
	--but 1 row as efected in the code
	-- Result: query executed successfully. Took 0ms, 1 rows affected

	
