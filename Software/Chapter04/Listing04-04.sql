USE AdventureWorks;
GO

DECLARE @i int = 1;

WHILE @i <= 10
BEGIN
	PRINT @i;

	SET @i = @i + 1;

	CONTINUE; -- Force the WHILE loop to restart

	PRINT 'The CONTINUE keyword ensures that this will never be printed.';
END
GO
