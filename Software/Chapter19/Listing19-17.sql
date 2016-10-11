USE AdventureWorks;
GO

SELECT
  BusinessEntityID,
  LastName,
  FirstName,
  MiddleName
FROM Person.Person
WHERE LastName = N'Duffy';
GO

