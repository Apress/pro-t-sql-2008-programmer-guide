USE AdventureWorks;
GO

SELECT
	CountryRegionCode,
	Northwest,
	Northeast,
	Southwest,
	Southeast,
	Central
FROM
(
	SELECT
		t.CountryRegionCode,
		t.Name
	FROM Sales.SalesOrderHeader soh
	INNER JOIN Sales.SalesTerritory t
		ON soh.TerritoryID = t.TerritoryID
	WHERE t.CountryRegionCode = 'US'
) p
PIVOT
(
	COUNT (Name)
	FOR Name
	IN
	(
		Northwest,
		Northeast,
		Southwest,
		Southeast,
		Central
	)
) AS pvt;
GO
