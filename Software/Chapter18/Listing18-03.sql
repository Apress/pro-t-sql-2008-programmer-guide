USE AdventureWorks;
GO

CREATE PROCEDURE dbo.TestError3 (@e int OUTPUT)
AS
BEGIN

  SET @e = 0;

  BEGIN TRY
    INSERT INTO Person.Address (AddressID)
    VALUES (1);
  END TRY
  
  BEGIN CATCH
    SET @e = ERROR_NUMBER();
    
    PRINT N'Error Code = ' + CAST(@e AS nvarchar(10));
    PRINT N'Error Procedure = ' + ERROR_PROCEDURE();
    PRINT N'Error Message = ' + ERROR_MESSAGE();
  END CATCH
  
END
GO

DECLARE @ret int,
  @e int;
EXEC @ret = dbo.TestError3 @e OUTPUT;
PRINT N'Error code = ' + CAST(@e AS nvarchar(10));
PRINT N'Return value = ' + CAST(@ret AS nvarchar(10));
GO
