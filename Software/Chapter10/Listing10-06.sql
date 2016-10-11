USE AdventureWorks;
GO

SELECT
  ProductModelID,
  Name,
  CatalogDescription
FROM Production.ProductModel
WHERE CONTAINS
(
  (
    Name, 
    CatalogDescription
  ),
  N'FORMSOF(INFLECTIONAL, sport)'
);
GO
