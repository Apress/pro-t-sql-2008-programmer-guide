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
  N'"tube" | FORMSOF(INFLECTIONAL, sport)'
);
GO
