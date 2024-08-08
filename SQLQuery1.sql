CREATE DATABASE mydatabase;
USE mydatabase;

SELECT 
  name 
FROM sys.tables; 


CREATE TABLE Customers(
	CustomerId int NOT NULL IDENTITY(1,1),
	Name varchar(100) NOT NULL,
	Country varchar(50) NOT NULL,
	PRIMARY KEY (CustomerId),
)

INSERT INTO Customers (CustomerId, Name, Country)
VALUES (1, 'John Hammond', 'United States')

SELECT * FROM Users;

ALTER TABLE customers
ADD photos varbinary (max); 




