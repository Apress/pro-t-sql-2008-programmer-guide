USE AdventureWorks;
GO

DECLARE @i int = 20;
SELECT TOP (@i) PERCENT 
  FirstName,
  MiddleName,
  LastName
FROM Person.Person
ORDER BY
  FirstName,
  MiddleName,
  LastName;
GO
