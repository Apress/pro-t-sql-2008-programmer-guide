USE AdventureWorks;
GO

DECLARE @product_name NVARCHAR(50) = N'Mountain%';
DECLARE @sql_stmt NVARCHAR(128) = N'SELECT ProductID, Name ' +
    N'FROM Production.Product ' +
    N'WHERE Name LIKE @name';
EXECUTE  sp_executesql @sql_stmt, 
    N'@name NVARCHAR(50)', 
    @name = @product_name;
GO
