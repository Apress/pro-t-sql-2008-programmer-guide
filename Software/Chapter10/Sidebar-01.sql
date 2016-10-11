USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name,
  CatalogDescription,
  Instructions
FROM Production.ProductModel
WHERE FREETEXT(*, N'sock')
	AND ProductModelID < 100;
GO
