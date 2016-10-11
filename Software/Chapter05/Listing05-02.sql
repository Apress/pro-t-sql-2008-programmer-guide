USE AdventureWorks;
GO

CREATE FUNCTION dbo.CalculateFactorial (@n int = 1)
RETURNS decimal(38, 0)
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
RETURN
	(CASE
		WHEN @n <= 0 THEN NULL
		WHEN @n > 1 THEN CAST(@n AS decimal(38, 0)) * dbo.CalculateFactorial (@n - 1)
		WHEN @n = 1 THEN 1
	END);
END;
GO