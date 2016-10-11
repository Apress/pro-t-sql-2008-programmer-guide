USE AdventureWorks;
GO

WITH Numbers (n)
AS
(
	SELECT 1 AS n

	UNION ALL

	SELECT n + 1
	FROM Numbers
	WHERE n < 10
)
SELECT n
FROM Numbers;
GO