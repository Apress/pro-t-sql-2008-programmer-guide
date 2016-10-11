USE AdventureWorks;
GO

CREATE FUNCTION dbo.CalculateFactorial (@n int = 1)
RETURNS float
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
	DECLARE @result float;
	SET @result = NULL;
	IF @n > 0
	BEGIN
		SET @result = 1.0;
		WITH Numbers (num)
		AS
		(
			SELECT 1

			UNION ALL

			SELECT num + 1
			FROM Numbers
			WHERE num < @n
		)
		SELECT @result = @result * num
		FROM Numbers;
	END;
	RETURN @result;
END;
GO