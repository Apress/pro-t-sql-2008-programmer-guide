USE AdventureWorks;
GO

DECLARE @i int = NULL;

IF @i = 10
	PRINT 'TRUE.';
ELSE IF NOT (@i = 10)
	PRINT 'FALSE.';
ELSE
	PRINT 'UNKNOWN.';
GO
