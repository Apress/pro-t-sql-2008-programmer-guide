USE AdventureWorks;
GO

DECLARE @sql_stmt NVARCHAR(512) = N'CREATE TABLE #Temp_ProductIDs ' +
  N'(' +
  N'  ProductID int NOT  NULL PRIMARY KEY' +
  N'); ' +
  N'INSERT INTO #Temp_ProductIDs (ProductID) ' +
  N'SELECT ProductID ' +
  N'FROM Production.Product;' ;

EXECUTE (@sql_stmt);

SELECT ProductID
FROM #Temp_ProductIDs;
GO
