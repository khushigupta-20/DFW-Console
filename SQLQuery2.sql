-- Drop InsertCustomer if it exists
IF OBJECT_ID('InsertCustomer', 'P') IS NOT NULL
    DROP PROCEDURE InsertCustomer;
GO

-- Create InsertCustomer stored procedure
CREATE PROCEDURE InsertCustomer
    @Name NVARCHAR(50),
    @Country NVARCHAR(50),
    @Photos VARBINARY(MAX)
AS
BEGIN
    INSERT INTO Customers (Name, Country, Photos) VALUES (@Name, @Country, @Photos);
END;
GO

-- Drop DeleteCustomer if it exists
IF OBJECT_ID('DeleteCustomer', 'P') IS NOT NULL
    DROP PROCEDURE DeleteCustomer;
GO

-- Create DeleteCustomer stored procedure
CREATE PROCEDURE DeleteCustomer
    @CustomerId INT
AS
BEGIN
    DELETE FROM Customers WHERE CustomerId = @CustomerId;
END;
GO

-- Drop UpdateCustomer if it exists
IF OBJECT_ID('UpdateCustomer', 'P') IS NOT NULL
    DROP PROCEDURE UpdateCustomer;
GO

-- Create UpdateCustomer stored procedure
CREATE PROCEDURE UpdateCustomer
    @CustomerId INT,
    @Name NVARCHAR(50),
    @Country NVARCHAR(50)
AS
BEGIN
    UPDATE Customers SET Name = @Name, Country = @Country WHERE CustomerId = @CustomerId;
END;
GO

-- Drop GetCustomers if it exists
IF OBJECT_ID('GetCustomers', 'P') IS NOT NULL
    DROP PROCEDURE GetCustomers;
GO

-- Create GetCustomers stored procedure
CREATE PROCEDURE GetCustomers
AS
BEGIN
    SELECT * FROM Customers;
END;
GO

-- Drop GetCustomerPhoto if it exists
IF OBJECT_ID('GetCustomerPhoto', 'P') IS NOT NULL
    DROP PROCEDURE GetCustomerPhoto;
GO

-- Create GetCustomerPhoto stored procedure
CREATE PROCEDURE GetCustomerPhoto
    @CustomerId INT
AS
BEGIN
    SELECT Photos, Name FROM Customers WHERE CustomerId = @CustomerId AND Photos IS NOT NULL;
END;
GO
