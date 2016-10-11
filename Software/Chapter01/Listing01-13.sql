USE AdventureWorks;
GO

DECLARE @i INT = 0;		-- Changed this statement to initialize @i to 0

SELECT @i = @i + 5;

SELECT @i;
GO