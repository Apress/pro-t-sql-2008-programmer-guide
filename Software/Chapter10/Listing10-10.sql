USE AdventureWorks;
GO

SELECT
  ftt.[KEY],
  ftt.[RANK], 
  pm.ProductModelID,
  pm.Name
FROM FREETEXTTABLE
(
  Production.ProductModel, 
  Instructions, 
  N'aluminum'
) ftt
INNER JOIN Production.ProductModel pm
  ON ftt.[KEY] = pm.ProductModelID;
GO
