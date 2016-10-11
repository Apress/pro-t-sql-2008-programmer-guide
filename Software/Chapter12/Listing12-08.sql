USE AdventureWorks;
GO

SELECT
  p.NameStyle AS "processing-instruction(nameStyle)",
  p.BusinessEntityID AS "Person/@ID",
  p.ModifiedDate AS "comment()",
  pp.PhoneNumber AS "text()",
  FirstName AS "Person/Name/First",
  MiddleName AS "Person/Name/Middle",
  LastName AS "Person/Name/Last",
  EmailAddress AS "Person/Email"
FROM Person.Person p
INNER JOIN Person.EmailAddress e
  ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.PersonPhone pp
  ON p.BusinessEntityID = pp.BusinessEntityID
FOR XML PATH;
GO