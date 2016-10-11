USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name
FROM Production.ProductModel
WHERE CONTAINS(Name, N'"bot*"'); 
GO
