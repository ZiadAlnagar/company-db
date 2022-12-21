-- 1- Retrieve the customer ID and name in which their age is older than 20 along with its corresponding order
CREATE PROCEDURE spCustomerOlderThan20InfoGet
AS
SELECT c.CustomerId, FirstName, LastName
FROM Customer c INNER JOIN Customer_Order o
ON c.CustomerId = o.CustomerId
WHERE DATEDIFF(yy, BirthDate, '1-1-2021') > 20;
GO

EXEC spCustomerOlderThan20InfoGet;
GO

-- 2- Retrieve product ID and the description of the product in which the quantity of the product should be greater than 2.
CREATE PROCEDURE spProductQuantityGreaterThan2Get
AS
SELECT ProductId, ProductDescription
FROM Product
WHERE Quantity > 2
GO

EXEC spProductQuantityGreaterThan2Get;
GO

-- 3- Retrieve the customer ID and the customer order in which the customer last name should end by ‘el’.
CREATE PROCEDURE spCustomerOrderLastNameLike
AS
SELECT c.CustomerId, OrderId
FROM Customer c INNER JOIN Customer_Order o
ON c.CustomerId = o.CustomerId
WHERE LastName LIKE '%el'
GO

EXEC spCustomerOrderLastNameLike
GO

-- 4- Retrieve the order ID and its status along with the product name
CREATE PROCEDURE spOrderDetailsGet
AS
SELECT o.OrderId, OrderStatus, ProductName
FROM ((Customer_Order o INNER JOIN OrderProduct op
ON o.OrderId = op.OrderId) INNER JOIN Product p
ON p.ProductId = op.ProductId);
GO

EXEC spOrderDetailsGet;
GO

-- 5- Retrieve the product names and the order ID that has been ordered by customer his first name is ‘Hassan’
CREATE PROCEDURE spProductNameThatHassanOrderGet
AS
SELECT p.ProductId, o.OrderId
FROM ((Customer_Order o INNER JOIN OrderProduct op
ON o.OrderId = op.OrderId) INNER JOIN Product p
ON p.ProductId = op.ProductId)
WHERE o.CustomerId IN (SELECT CustomerId
						 FROM Customer
						 WHERE FirstName = 'Hassan');
GO

EXEC spProductNameThatHassanOrderGet;
GO

-- 6= Drop Procedure
DROP PROCEDURE spProductDescriptionByProductIdGet;
GO

-- 1- Retrieve the customer ID, First name and the order ID of each order the customer did
CREATE PROCEDURE spOrderDetailsByCustomerIdGet
@CustomerId INT
AS
SELECT c.CustomerId, FirstName, OrderId
FROM Customer c INNER JOIN Customer_Order o
ON c.CustomerId = o.CustomerId
WHERE c.CustomerId = @CustomerId;
GO

EXEC spOrderDetailsByCustomerIdGet 1;
GO

-- 2- Retrieve the details of order 8 and its status
CREATE PROCEDURE spOrderDetailsByOrderIdGet
@OrderId INT = 8
AS
SELECT *
FROM Customer_Order
WHERE OrderId = @OrderId;
GO

EXEC spOrderDetailsByOrderIdGet;
-- Default value
GO

-- 3- Retrieve the product description and its Name for the product with ID 95 under the Alias ‘The name of the product is TV and its description is smartelectonics: ’
CREATE PROCEDURE spProductDescriptionByProductIdGet
@ProductId INT = 95,
@ProductNameAndDescription VARCHAR(128) OUT
AS
SELECT ProductName, ProductDescription
FROM Product
WHERE ProductId = @ProductId;

SELECT @ProductNameAndDescription = (SELECT ProductName + 'and its description is' + ProductDescription
									 FROM Product
									 WHERE ProductId = @ProductId);
-- ERROR: PRINT 'The Name of the product is ' + @ProductDescriptionAndName;
GO

EXEC spProductDescriptionByProductIdGet 95, OUT;
GO

-- 4- Calculate the area of the circle (A=PI *r*r) note that the Pi= 3.14
CREATE PROCEDURE spCalcualteTheAreaOfCicrleGet
@pi FLOAT = 3.14,
@radius FLOAT,
@area VARCHAR(16) OUT
AS
SELECT @area = @radius * @radius * @pi;

PRINT  'The area of a circle is :' + @area;
GO

EXEC spCalcualteTheAreaOfCicrleGet 3.14, 5, OUT
GO

-- 5- Hide all the information for the customer and its order using stored procedure
CREATE PROCEDURE spEncryptCustomerInfoAndTheirOrder
WITH ENCRYPTION
-- Sucurity
AS
SELECT c.CustomerId, FirstName, OrderId
FROM Customer c INNER JOIN Customer_Order o
ON c.CustomerId = o.CustomerId
GO

EXEC spEncryptCustomerInfoAndTheirOrder;
GO

sp_helptext spEncryptCustomerInfoAndTheirOrder;

-- 6- Insert the records in table product into other table using stored procedure (you can specify different values of product description)
CREATE TABLE ProductBackUp
(
ProductId int NOT NULL,
ProductName VARCHAR(32),
ProductDescription VARCHAR(64),
Quantity int,
Price INT

CONSTRAINT PKProductBackUp_ProductId
PRIMARY KEY (ProductId)
)
GO

CREATE PROCEDURE spBackUpSpecificProductTableItems
@productDescription VARCHAR(64)
AS
INSERT INTO ProductBackUp
SELECT * 
FROM Product
WHERE ProductDescription = @productDescription;
GO

EXEC spBackUpSpecificProductTableItems 'SmartPhone'
GO

Select* FROM ProductBackUp;