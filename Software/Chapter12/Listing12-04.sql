USE AdventureWorks;
GO

SELECT 
  p.BusinessEntityID AS "@ID",
  e.EmailAddress AS "@EmailAddress",
  p.FirstName AS "Person/Name/First",
  pp.PhoneNumber AS "Phone/BusinessPhone",
  p.MiddleName AS "Person/Name/Middle",
  p.LastName AS "Person/Name/Last"
FROM Person.Person p
INNER JOIN Person.EmailAddress e
  ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.PersonPhone pp
  ON p.BusinessEntityID = pp.BusinessEntityID
  AND pp.PhoneNumberTypeID = 3
FOR XML PATH;
GO