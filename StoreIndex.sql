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

-- 8. Disable the index on product table.ALTER INDEX IX_ProductQuantityON ProductDISABLE;-- 9. Enable the index on product table.ALTER INDEX IX_ProductQuantityON ProductREBUILD;-- 1. Create a non-clustered index that have all customer ID in descending orderCREATE NONCLUSTERED INDEX IX_CustomerIdDescON Customer(CustomerId DESC);-- 2. Create a non-clustered index that have all the order information where the data of order arranged in ascending orderCREATE INDEX IX_OrderON Customer_Order(OrderId, CustomerId, OrderDate ASC, OrderStatus);-- 3. Create a non-clustered index that have the quantity of the products arranged in descending order along with the product ID.CREATE INDEX IX_ProductQuantityDESCON Product(ProductID, Quantity DESC);-- 4. Create an index that have all the unique customer’s nameCREATE UNIQUE INDEX UIX_CustomerUniqueFirstNameON Customer(FirstName);-- 5. Show all the index information related to table CustomerEXEC sp_help Customer;-- 6. Show all the storage procedure information retrieval in table order.EXEC sp_helpindex 'Customer'-- 7. Create a filtered index of customer’s DOB in ascending order where DOB is less than 1992CREATE UNIQUE INDEX UIX_CustomerBirthDateASCBefore1992ON Customer(BirthDate ASC)WHERE BirthDate < '1-1-1992';-- 8. Create an index on order’s date and then include its statusCREATE INDEX IX_OrderStatusON Customer_Order(OrderDate)INCLUDE (OrderStatus);