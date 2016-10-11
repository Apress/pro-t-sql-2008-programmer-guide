USE AdventureWorks;
GO

WITH Numbers (Num)
AS
(
	SELECT 1

	UNION ALL

	SELECT Num + 1
	FROM Numbers
	WHERE Num < 100
)
SELECT Num
FROM Numbers;
GO