-- 1. Create the following views in SQL on the Store database schema
-- A. A view that has the customer name and Customer Age greater than 15, and Address.
CREATE VIEW vwCustomerOlderThan15 AS
SELECT FirstName, LastName, BirthDate, ResidenceAddress
FROM Customer
WHERE DATEDIFF(yy, BirthDate, '1-1-2021') > 29;
GO

SELECT * 
FROM vwCustomerOlderThan15;
GO

-- B. A view that has the Customer name and order ID in which the order must be delivered
CREATE VIEW vwDeliveredOrders AS
SELECT FirstName, OrderId
FROM Customer c INNER JOIN Customer_Order o
ON c.CustomerId = o.CustomerId
WHERE OrderStatus = 'delivered';
GO

SELECT * FROM vwDeliveredOrders;
GO

-- C. A view that has the product name, Product description along with the quantity
CREATE OR ALTER VIEW vwProductDetails AS
SELECT ProductId, ProductName, ProductDescription, Quantity
FROM Product
WHERE Quantity >2
WITH CHECK OPTION;
GO

SELECT * FROM vwProductDetails;
GO

-- D. A view that has the Order ID and its date and its status with the product name and its description.
CREATE VIEW vwOrderProductInformation AS
SELECT o.OrderId, OrderDate, OrderStatus, ProductName, ProductDescription
FROM ((OrderProduct op INNER JOIN Customer_Order o
ON o.OrderId = op.OrderId) INNER JOIN Product p
ON p.ProductId = op.ProductId);
GO

SELECT * FROM vwOrderProductInformation;
GO

-- 2. Alter View in table customer that has ‘ss’ in the customer name
CREATE OR ALTER VIEW vwCustomerInformation AS
SELECT CustomerId, FirstName, LastName
FROM Customer
WHERE FirstName LIKE '%ss%';
GO

SELECT * FROM vwCustomerInformation;


-- 3. Alter view in table products that retrieve the quantity more than 2.
-- Solution 1.C

-- 4. Drop view that contain order ID and product name.
DROP VIEW vwOrderProductInformation;
GO

-- 1. Create a view that has all the customer data, and name it vwCustomerData, where the customer’s first name is ‘Hassan’.
CREATE VIEW vwCustomerData AS
SELECT *
FROM Customer
WHERE FirstName = 'Hassan';
GO

SELECT * FROM vwCustomerData;
GO

-- 2. Create a view that has the product name, product description and quantity and name it vwProductDetails, where the product description has ‘art’ in it.
CREATE VIEW vwProductArtDetails AS
SELECT ProductName, ProductDescription, Quantity
FROM Product
WHERE ProductDescription LIKE '%art%';
GO

SELECT * FROM vwProductArtDetails;
GO

-- 3. Create a view that contains the orderID, product name, and customer’s address, and name it vwCustomerOrderDetails.
-- Note: Schema binding needs referenced tables to have two-part name as a workaround solution use 'dbo.tablename'
CREATE OR ALTER VIEW vwCustomerOrderDetails WITH SCHEMABINDING AS
SELECT o.OrderId, ProductName, ResidenceAddress
FROM (((dbo.Customer c INNER JOIN dbo.Customer_Order o
ON c.CustomerId = o.CustomerId) INNER JOIN dbo.OrderProduct op
ON o.OrderId = op.OrderId) INNER JOIN dbo.Product p
ON p.ProductId = op.OrderId);
GO

SELECT * FROM vwCustomerOrderDetails;

-- 4. Rename the VCustomerData to CustomerView.
EXEC sp_rename vwCustomerData, vwCustomerDetails;

-- 5. Alter the product’s view to have with check options.
-- Note: The purpose of with check option is to ensure that all update and insert satisfy the condition in the view definition otherwise it will return an error
-- Solution 1.C

-- 6. Insert data into the product table using the view.
INSERT INTO vwProductDetails (ProductId, ProductName, ProductDescription, Quantity)
VALUES ('30','Charger', 'smart charger', '2');

INSERT INTO vwProductDetails
VALUES ('50','Charger', 'smart charger', '5');

-- 7. Insert data into the customer data using the view.
INSERT INTO vwCustomerDetails
SELECT 30, 'Ali','ali', '1994', 'maadi', '010555';
-- Cannot insert duplicate key row in object 'dbo.Customer' with unique index 'UIX_CustomerUniqueFirstName'. The duplicate key value is (hassan).

-- 8. Retrieve the data from the product’s view.
-- Solution 1.C

-- 9. Create an index on the vCustomerOrderDetails view.
-- Note: Cannot create index on a view without the 'with schemabinding As'
CREATE UNIQUE CLUSTERED INDEX UCIX_vwCustomerOrderDetails
ON vwCustomerOrderDetails(OrderId, ProductName, ResidenceAddress);