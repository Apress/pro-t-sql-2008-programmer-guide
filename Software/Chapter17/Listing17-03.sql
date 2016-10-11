USE AdventureWorks;
GO

SELECT 
  sp.BusinessEntityID
FROM Sales.SalesPerson sp
WHERE NOT EXISTS 
(
  SELECT
    soh.SalesPersonID
  FROM Sales.SalesOrderHeader soh
  WHERE soh.SalesPersonID = sp.BusinessEntityID
  AND soh.OrderDate BETWEEN '2002-06-01' AND '2002-06-30'
);
GO
