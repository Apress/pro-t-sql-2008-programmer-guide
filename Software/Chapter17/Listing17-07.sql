USE AdventureWorks;
GO

SELECT TOP 
(
  SELECT COUNT(*) / 5
  FROM Person.Person
)
  FirstName,
  MiddleName,
  LastName
FROM Person.Person
ORDER BY
  FirstName,
  MiddleName,
  LastName;
GO
