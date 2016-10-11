USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name
FROM Production.ProductModel
WHERE CONTAINS(Instructions, N'aluminum NEAR jig');
GO
