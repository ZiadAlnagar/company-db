CREATE DATABASE Store;

CREATE TABLE Customer
(
	CustomerId INT NOT NULL,
	FirstName VARCHAR(32),
	LastName VARCHAR(32),
	BirthDate DATE,
	ResidenceAddress VARCHAR(64),
	PhoneNumber VARCHAR(32),

	CONSTRAINT PKCustomer_CustomerId
	PRIMARY KEY (CustomerId)
);

CREATE TABLE Customer_Order
(
	OrderId INT NOT NULL,
	CustomerId INT NOT NULL,
	OrderStatus VARCHAR(32),
	OrderDate DATE

	CONSTRAINT PKOrder_OrderId
	PRIMARY KEY (OrderId),

	CONSTRAINT FKOrder_CustomerId
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Product
(
	ProductId INT NOT NULL,
	ProductName VARCHAR(32),
	ProductDescription VARCHAR(64),
	Quantity INT,
	Price INT,

	CONSTRAINT PKProduct_ProductId
	PRIMARY KEY (ProductId)
);

CREATE TABLE OrderProduct
(
	OrderId INT NOT NULL,
	ProductId INT NOT NULL,

	CONSTRAINT PKOrderCustomer_OrderIdProductId
	PRIMARY KEY (OrderId, ProductId)
);

INSERT INTO Customer
VALUES
(0,'Hassan','Nada','1-1-1992','Cairo','0222222254'),
(1,'Magdy','Adel','2-2-1988','Cairo','03334432'),
(2,'Medhat','leo','3-3-1987','Alexandria','099990');

INSERT INTO Customer_Order
VALUES
(8,1,'Delivered','2-1-1992'),
(9,0,'Pending','1-5-1992'),
(10,2,'On the way','4-1-1992'),
(11,2,'On the way','1-6-1992');

INSERT INTO Product
VALUES
(95,'TV','SmartElectronics',5,'2500'),
(96,'Mobile','SmartPhone',1,'28800'),
(97,'Camera','SmartElectronics',3,'15689'),
(98,'Airpods','SmartElectronics',6,'5877965');

INSERT INTO OrderProduct
VALUES
(8,95),
(9,96),
(10,97);

--------------------------------------------------
-----										 -----
-----			Alter or Delete				 -----
-----										 -----
--------------------------------------------------

--DROP DATABASE Store;

--DROP TABLE Customer;

--ALTER TABLE Customer
--ADD IsMarried BIT;

--ALTER TABLE Customer
--DROP COLUMN IsMarried;

--ALTER TABLE Customer
--ADD CONSTRAINT FKCustomer_OrderId
--	FOREIGN KEY (OrderId) REFERENCES Customer_Order(OrderId);

--ALTER TABLE Customer
--DROP CONSTRAINT FKCustomer_OrderId;

--------------------------------------------------
-----										 -----
-----				Basic Query				 -----
-----										 -----
--------------------------------------------------

--------------------------------------------------
-----		 SELECT <Attribute List>*		 -----
-----		 FROM <Table List>*				 -----
-----		 WHERE <Condition>				 -----
-----		 ORDER BY <Condition>			 -----
-----		 GROUP BY <Condition>			 -----
--------------------------------------------------

--------------------------------------------------

--------------------------------------------------
-----										 -----
-----				Join Tables				 -----
-----										 -----
--------------------------------------------------

SELECT FirstName, LastName, OrderId, OrderStatus
FROM Customer ,Customer_Order
WHERE Customer.CustomerId =  Customer.CustomerId;

SELECT FirstName, LastName, OrderId, OrderStatus
FROM Customer JOIN Customer_Order
ON Customer.CustomerId =  Customer.CustomerId;