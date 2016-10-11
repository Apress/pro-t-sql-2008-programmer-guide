USE AdventureWorks;
GO

SELECT
  ct.[RANK],
  ct.[KEY],
  pm.[Name] 
FROM CONTAINSTABLE
(
  Production.ProductModel, 
  Instructions, 
  N'aluminum OR polish'
) ct
INNER JOIN Production.ProductModel pm
  ON ct.[KEY] = pm.ProductModelID
ORDER BY ct.[RANK] DESC;

SELECT 
  ct.[RANK], 
  ct.[KEY], 
  pm.[Name] 
FROM CONTAINSTABLE
(
  Production.ProductModel, 
  Instructions, 
  N'ISABOUT(aluminum WEIGHT(1.0), polish WEIGHT(0.1))'
) ct
INNER JOIN Production.ProductModel pm
  ON ct.[KEY] = pm.ProductModelID
ORDER BY ct.[RANK] DESC;
GO
