USE AdventureWorks;
GO

SELECT
	t.CountryRegionCode,
	SUM
	(
		CASE WHEN t.Name = 'Northwest' THEN 1
			ELSE 0
			END
	) AS Northwest,
	SUM
	(
		CASE WHEN t.Name = 'Northeast' THEN 1
			ELSE 0
			END
	) AS Northeast,
	SUM
	(
		CASE WHEN t.Name = 'Southwest' THEN 1
			ELSE 0
			END
	) AS Southwest,
	SUM
	(
		CASE WHEN t.Name = 'Southeast' THEN 1
			ELSE 0
			END
	) AS Southeast,
	SUM
	(
		CASE WHEN t.Name = 'Central' THEN 1
			ELSE 0
			END
	) AS Central
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory t
	ON soh.TerritoryID = t.TerritoryID
WHERE t.CountryRegionCode = 'US'
GROUP BY t.CountryRegionCode;
GO
