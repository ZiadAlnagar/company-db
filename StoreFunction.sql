-- 1- Create a function that retrieve the number of orders
CREATE FUNCTION NumberOfOrders()
RETURNS INT
AS
BEGIN
DECLARE @TotalNumOfOrders INT
SELECT @TotalNumOfOrders = COUNT(*)
FROM Customer_Order
RETURN @TotalNumOfOrders
END
GO

SELECT dbo.NumOfOrders() AS TotalOrders;
GO

-- 2- Create a function that calculates the multiplication of two numbers


-- 3- Create a function that retrieve the first name of a customer


-- 4- Create a function that retrieve all the customer first name and their orders


-- 5- Create a function that retrieve the information of the customer with id 1


-- 6- Create a function that retrieve the product name and each order ID that has been made for this product
