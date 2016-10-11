USE AdventureWorks;
GO

SELECT
  ProductID, 
  Name
FROM Production.Product
WHERE FREETEXT(*, N'flat');
GO

