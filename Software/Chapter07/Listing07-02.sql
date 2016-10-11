USE AdventureWorks;
GO

UPDATE HumanResources.Employee
SET MaritalStatus = 'M'
WHERE BusinessEntityID IN (1, 2);

SELECT BusinessEntityID, NationalIDNumber, MaritalStatus, ModifiedDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN (1, 2);

GO

