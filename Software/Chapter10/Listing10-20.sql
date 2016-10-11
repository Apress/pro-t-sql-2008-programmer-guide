USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name
FROM Production.ProductModel
WHERE FREETEXT(*, N'instructions');
GO



