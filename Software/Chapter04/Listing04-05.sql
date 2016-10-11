USE AdventureWorks;
GO

DECLARE @i int = 1;

WHILE @i <= 10
BEGIN
	PRINT @i;

	SET @i = @i + 1;

	BREAK; -- Force the WHILE loop to terminate

	PRINT 'The BREAK keyword ensures that this will never be printed.';
END
GO
