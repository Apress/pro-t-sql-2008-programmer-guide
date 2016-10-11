USE AdventureWorks;
GO

CREATE FUNCTION dbo.CalculateCircleArea (@Radius float = 1.0)
RETURNS float
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
	RETURN PI() * POWER(@Radius, 2);
END;
GO

SELECT dbo.CalculateCircleArea(10);
SELECT dbo.CalculateCircleArea(NULL);
SELECT dbo.CalculateCircleArea(2.5);
GO