USE AdventureWorks;
GO

SELECT
  [KEY],
  [RANK]
FROM CONTAINSTABLE
(
  Production.ProductModel, 
  [Name], 
  N'FORMSOF(INFLECTIONAL, tours)'
);
GO
