-- Listing 14-12
SELECT 
  ProductID,
  dbo.Median(UnitPrice) AS MedianUnitPrice
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
