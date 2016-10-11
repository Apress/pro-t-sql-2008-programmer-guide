USE AdventureWorks;
GO

-- Declare variables
DECLARE @sql nvarchar(4000);

DECLARE @temp_pivot table
(
	TerritoryID int NOT NULL PRIMARY KEY,
	CountryRegion nvarchar(20) NOT NULL,
	CountryRegionCode nvarchar(3) NOT NULL
);

-- Get column names from source table rows
INSERT INTO @temp_pivot
(
	TerritoryID,
	CountryRegion,
	CountryRegionCode
)
SELECT DISTINCT
	TerritoryID,
	Name,
	CountryRegionCode
FROM Sales.SalesTerritory;

-- Generate dynamic SQL query
SET @sql = N'SELECT' +
	SUBSTRING
	(
		(
			SELECT N', SUM(CASE WHEN t.TerritoryID = ' +
			CAST(TerritoryID AS NVARCHAR(3)) +
			N' THEN 1 ELSE 0 END) AS ' + QUOTENAME(CountryRegion) AS "*"
			FROM @temp_pivot
			FOR XML PATH('')
		), 2, 4000
	) +
N' FROM Sales.SalesOrderHeader soh ' +
N' INNER JOIN Sales.SalesTerritory t ' +
N' ON soh.TerritoryID = t.TerritoryID; ' ;

-- Print and execute dynamic SQL
PRINT @sql;
EXEC (@sql);
GO
