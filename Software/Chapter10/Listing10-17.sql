USE AdventureWorks;
GO

SELECT
  ProductID,
  Name,
  Color
FROM Production.Product
WHERE FREETEXT(*, N'navy');
GO

