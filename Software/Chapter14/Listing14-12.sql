USE AdventureWorks;
GO

SELECT 
  ProductID,
  dbo.Median(UnitPrice) AS MedianUnitPrice
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
GO


