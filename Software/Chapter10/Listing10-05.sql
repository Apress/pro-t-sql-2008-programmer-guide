USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name,
  CatalogDescription,
  Instructions
FROM Production.ProductModel
WHERE CONTAINS(*, N'weld');
GO
