USE AdventureWorks;
GO

SELECT 
  BusinessEntityID
FROM Sales.SalesPerson

INTERSECT

SELECT
  DISTINCT SalesPersonID
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2002-06-01' AND '2002-06-30';
GO
