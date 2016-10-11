USE AdventureWorks;
GO

SELECT 
  ProductID, 
  dbo.Range(UnitPrice) AS UnitPriceRange
FROM Sales.SalesOrderDetail
WHERE UnitPrice > 0
GROUP BY ProductID;
GO


