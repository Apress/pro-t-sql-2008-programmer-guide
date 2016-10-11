USE AdventureWorks;
GO

CREATE PROCEDURE dbo.TestError (@e int OUTPUT)
AS
BEGIN
  INSERT INTO Person.Person(BusinessEntityID)
  VALUES (1);
	
  PRINT N'Error code in procedure = ' + CAST(@@error AS nvarchar(10));

  SET @e = @@error;
END
GO

DECLARE @ret int,
  @e int;
EXEC @ret = dbo.TestError @e OUTPUT;
PRINT N'Returned error code = ' + CAST(@e AS nvarchar(10));
PRINT N'Return value = ' + CAST(@ret AS nvarchar(10));
GO
