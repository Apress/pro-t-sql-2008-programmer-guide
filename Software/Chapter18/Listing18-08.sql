USE AdventureWorks;
GO

DECLARE @min_product_id int = 500;
DECLARE @sql_stmt nvarchar(128) =
  N'SELECT ProductID ' +
  N'FROM Production.Product ' +
  N'WHERE ProductID >= ' + CAST(@min_product_id AS nvarchar(10));
EXECUTE (@sql_stmt);
GO
