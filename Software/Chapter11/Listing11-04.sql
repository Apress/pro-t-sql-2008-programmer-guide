USE AdventureWorks;
GO

SELECT
  ProductID,
  Name,
  ProductNumber
FROM Production.Product
WHERE ProductID = 770
  FOR XML RAW;
GO




