USE AdventureWorks;
GO

SELECT
	DATEPART(year, soh.OrderDate) AS SalesYear,
	st.Name AS TerritoryName,
	SUM(soh.SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory st
	ON soh.TerritoryID = st.TerritoryID
WHERE st.CountryRegionCode = 'US'
GROUP BY
	DATEPART(year, soh.OrderDate),
	st.Name
WITH ROLLUP
ORDER BY
	DATEPART(year, soh.OrderDate),
	st.Name;
GO
