USE AdventureWorks;
GO

CREATE FULLTEXT INDEX 
ON Production.ProductModel
(
  CatalogDescription LANGUAGE English,
  Instructions LANGUAGE English,
  Name LANGUAGE English
)
KEY INDEX PK_ProductModel_ProductModelID 
ON 
(
  AdventureWorksFTCat
) 
WITH 
(
  CHANGE_TRACKING AUTO
);
GO

ALTER FULLTEXT INDEX 
ON Production.ProductModel ENABLE;
GO
