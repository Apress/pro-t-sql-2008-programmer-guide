USE AdventureWorks;
GO

DECLARE @product_name nvarchar(50) = N'Mountain';
DECLARE @sql_stmt NVARCHAR(128) = N'SELECT ProductID, Name ' +
    N'FROM Production.Product ' +
    N'WHERE Name LIKE ''' +
    @product_name + N'%''';
EXECUTE (@sql_stmt);
GO
