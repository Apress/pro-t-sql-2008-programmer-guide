USE AdventureWorks;
GO

SELECT
  FirstName,
  MiddleName,
  LastName
FROM Person.Contact
TABLESAMPLE (10 PERCENT);
GO
