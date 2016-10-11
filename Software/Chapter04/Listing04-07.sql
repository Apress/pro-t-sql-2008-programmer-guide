USE AdventureWorks;
GO

PRINT 'Step 1 complete. ';
GO

DECLARE @time_to_pass nvarchar(8);
SELECT @time_to_pass = N'00:00:03';

WAITFOR DELAY @time_to_pass;

PRINT 'Step 2 completed three seconds later. ';
GO
