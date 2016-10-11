USE AdventureWorks;
GO

CREATE FULLTEXT INDEX ON Production.Product
(
  Name LANGUAGE English,
  Color LANGUAGE English
)
KEY INDEX PK_Product_ProductID
ON (AdventureWorksFTCat) 
WITH 
(
  CHANGE_TRACKING AUTO,
  STOPLIST = SYSTEM
);
GO

ALTER FULLTEXT INDEX ON Production.Product
ENABLE;
GO
