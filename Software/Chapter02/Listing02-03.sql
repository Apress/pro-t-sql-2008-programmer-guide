USE AdventureWorks;
GO

DECLARE @x int = 4,
	@y int = 25,
	@s1 varchar(20) = 'Sql';

SET @x *= @y;

SET @s1 += ' Server';

SELECT @x, @s1;
GO