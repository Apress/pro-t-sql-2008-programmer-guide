USE AdventureWorks;
GO

SELECT DISTINCT 
  soh.SalesPersonID AS "SalesPerson/@ID",
  (
      SELECT soh2.SalesOrderID AS "data()"
      FROM Sales.SalesOrderHeader soh2
      WHERE soh2.SalesPersonID = soh.SalesPersonID
      FOR XML PATH ('')
  ) AS "SalesPerson/@Orders",
  p.FirstName AS "SalesPerson/Name/First",
  p.MiddleName AS "SalesPerson/Name/Middle",
  p.LastName AS "SalesPerson/Name/Last",
  e.EmailAddress AS "SalesPerson/Email"
FROM Sales.SalesOrderHeader soh
INNER JOIN Person.Person p
  ON p.BusinessEntityID = soh.SalesPersonID
INNER JOIN Person.EmailAddress e
  ON p.BusinessEntityID = e.BusinessEntityID
WHERE soh.SalesPersonID IS NOT NULL
FOR XML PATH;
GO