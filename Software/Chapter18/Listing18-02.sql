USE AdventureWorks;
GO

CREATE PROCEDURE dbo.TestError2 (@e int OUTPUT)
AS
BEGIN
  INSERT INTO Person.Person(BusinessEntityID)
  VALUES (1);
  
  SET @e = @@error;
	
  PRINT N'Error code in procedure = ' + CAST(@e AS nvarchar(10));
END
GO

DECLARE @ret int,
  @e int;
EXEC @ret = dbo.TestError2 @e OUTPUT;
PRINT N'Returned error code = ' + CAST(@e AS nvarchar(10));
PRINT N'Return value = ' + CAST(@ret AS nvarchar(10));
GO
