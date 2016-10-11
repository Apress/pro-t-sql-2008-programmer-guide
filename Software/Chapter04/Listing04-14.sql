USE AdventureWorks;
GO

SELECT SUM
	(
		CASE WHEN t.TerritoryID = 1 THEN 1
			ELSE 0
			END
	) AS [Northwest],
	SUM
	(
		CASE WHEN t.TerritoryID = 2 THEN 1
			ELSE 0
			END
	) AS [Northeast],
	SUM
	(
		CASE WHEN t.TerritoryID = 3 THEN 1
			ELSE 0
			END
	) AS [Central],
	SUM
	(
		CASE WHEN t.TerritoryID = 4 THEN 1
			ELSE 0
			END
	) AS [Southwest],
	SUM
	(
		CASE WHEN t.TerritoryID = 5 THEN 1
			ELSE 0
			END
	) AS [Southeast],
	SUM
	(
		CASE WHEN t.TerritoryID = 6 THEN 1
			ELSE 0
			END
	) AS [Canada],
	SUM
	(
		CASE WHEN t.TerritoryID = 7 THEN 1
			ELSE 0
			END
	) AS [France],
	SUM
	(
		CASE WHEN t.TerritoryID = 8 THEN 1
			ELSE 0
			END
	) AS [Germany],
	SUM
	(
		CASE WHEN t.TerritoryID = 9 THEN 1
			ELSE 0
			END
	) AS [Australia],
	SUM
	(
		CASE WHEN t.TerritoryID = 10 THEN 1
			ELSE 0
			END
	) AS [United Kingdom]
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory t
	ON soh.TerritoryID = t.TerritoryID;
GO
