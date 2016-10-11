USE AdventureWorks;
GO

WITH XMLNAMESPACES('http://www.apress.com/xml/sampleSqlXmlNameSpace' as ns)
SELECT
  p.BusinessEntityID AS "ns:Person/ID",
  p.FirstName AS "ns:Person/Name/First",
  p.MiddleName AS "ns:Person/Name/Middle",
  p.LastName AS "ns:Person/Name/Last",
  e.EmailAddress AS "ns:Person/Email"
FROM Person.Person p
INNER JOIN Person.EmailAddress e
  ON p.BusinessEntityID = e.BusinessEntityID
FOR XML PATH;
GO