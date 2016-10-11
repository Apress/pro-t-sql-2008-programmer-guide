USE AdventureWorks;
GO

SELECT TOP (10) PERCENT
  FirstName,
  MiddleName,
  LastName
FROM HumanResources.vEmployee
ORDER BY NEWID();
GO
