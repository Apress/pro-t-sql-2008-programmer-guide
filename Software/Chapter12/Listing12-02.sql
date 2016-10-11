USE AdventureWorks;
GO

SELECT 
  p.BusinessEntityID AS "Person/@ID",
  e.EmailAddress AS "Person/@Email",
  p.FirstName AS "Person/Name/First",
  p.MiddleName AS "Person/Name/Middle",
  p.LastName AS "Person/Name/Last"
FROM Person.Person p
INNER JOIN Person.EmailAddress e
  ON p.BusinessEntityID = e.BusinessEntityID
FOR XML PATH;
GO