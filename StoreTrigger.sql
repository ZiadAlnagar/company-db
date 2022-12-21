-- 1. Create separate table to keep track of the changes in the tables
CREATE TABLE Customer_Audit
(
	CustomerId INT NOT NULL,
	FirstName VARCHAR(32),
	LastName VARCHAR(32),
	BirthDate DATE,
	ResidenceAddress VARCHAR(64),
	PhoneNumber VARCHAR(32),
	audit_msg VARCHAR(16),
	audit_date VARCHAR(16)
);
GO

-- 2. Create trigger that trig all the new customer that has been inserted in table customer
CREATE TRIGGER tr_CustomerIns
ON Customer
FOR INSERT
AS
DECLARE @CustomerId INT;
DECLARE @FirstName VARCHAR(32);
DECLARE @LastName VARCHAR(32);
DECLARE @BirthDate DATE;
DECLARE @ResidenceAddress VARCHAR(64);
DECLARE @PhoneNumber VARCHAR(32);
DECLARE @audit_msg VARCHAR(16);
DECLARE @audit_date VARCHAR(16);

SELECT @CustomerId = i.CustomerId FROM inserted i;
SELECT @FirstName = i.FirstName FROM inserted i;
SELECT @LastName = i.LastName FROM inserted i;
SELECT @BirthDate = i.BirthDate FROM inserted i;
SELECT @ResidenceAddress = i.ResidenceAddress FROM inserted i;
SELECT @PhoneNumber = i.PhoneNumber FROM inserted i;
SELECT @audit_msg = 'Insert trigger executed';

INSERT INTO Customer_Audit
VALUES
(@CustomerId, @FirstName, @LastName, @BirthDate, @ResidenceAddress, @PhoneNumber, @audit_msg, GETDATE());

PRINT 'Trigger executed successfully'
GO

INSERT INTO Customer
VALUES
(101,'Manar','Abdelhamid','4-4-2020','NewGiza','0100123789'),
(5,'Medhatt','leo','5-3-2015','Alexandria','099990');
GO

-- 3. Create trigger that trig all the changes in the customer (the customer has been deleted from the database)
CREATE TRIGGER tr_CustomerDel
ON Customer
FOR DELETE
AS
DECLARE @CustomerId INT;
DECLARE @FirstName VARCHAR(32);
DECLARE @LastName VARCHAR(32);
DECLARE @BirthDate DATE;
DECLARE @ResidenceAddress VARCHAR(64);
DECLARE @PhoneNumber VARCHAR(32);
DECLARE @audit_msg VARCHAR(16);
DECLARE @audit_date VARCHAR(16);

SELECT @CustomerId = d.CustomerId FROM deleted d;
SELECT @FirstName = d.FirstName FROM deleted d;
SELECT @LastName = d.LastName FROM deleted d;
SELECT @BirthDate = d.BirthDate FROM deleted d;
SELECT @ResidenceAddress = d.ResidenceAddress FROM deleted d;
SELECT @PhoneNumber = d.PhoneNumber FROM deleted d;
SELECT @audit_msg = 'Delete trigger executed';

INSERT INTO Customer_Audit
VALUES
(@CustomerId, @FirstName, @LastName, @BirthDate, @ResidenceAddress, @PhoneNumber, @audit_msg, GETDATE());

PRINT 'Trigger executed successfully'
GO

DELETE FROM Customer WHERE CustomerId = 101;

-- 4. View all the triggers on table customer
SELECT *
FROM sys.triggers
WHERE is_disabled = 0;

-- 5. List the triggers on table customer
SELECT name, is_instead_of_trigger
FROM sys.triggers
WHERE type = 'TR';

-- 6. Hold the trigger on steady from working in table customer
ALTER TABLE CustomerDISABLE TRIGGER tr_CustomerIns;-- OR to disable em allALTER TABLE CustomerDISABLE TRIGGER ALL;-- 7. Delete all the triggers in our databaseDROP TRIGGER tr_CustomerDel;-- 8. Change trigger nameEXEC sp_rename 'tr_ProductIns', 'tr_CustomerIns';