USE AdventureWorks;
GO

SELECT
  BusinessEntityID,
  LastName,
  FirstName,
  MiddleName,
  Title
FROM Person.Person
WHERE LastName = N'Duffy';
GO

