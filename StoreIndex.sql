-- 1. Create index that have all customer ID from customer relation
-- As the index type not specified, the default is NONCLUSTERED
CREATE INDEX IX_CustomerID
ON Customer(CustomerId);

-- 2. Create index that have the full name of the customer with its Age and ID
CREATE INDEX IX_CustomerDetails
ON Customer(CustomerId, FirstName, LastName, BirthDate);

-- 3. Create index that have the products name, description along with its quantity
CREATE INDEX IX_ProductQuantity
ON Product(ProductName, ProductDescription, Quantity);

-- 4. Create index that have the order ID and the Product ID
CREATE INDEX IX_OrderProductID
ON OrderProduct(OrderId, ProductId);

-- 5. Retrieve all the index information from table customer
EXEC sp_helpindex Customer
GO

-- 6. Rename the index that contain the customer ID
EXEC sp_rename 'Customer.IX_CustomerID', 'IX_CustomerId', 'INDEX';

-- 7. Delete the index that has the customer ID.
DROP INDEX Customer.IX_CustomerId;

-- 8. Disable the index on product table.