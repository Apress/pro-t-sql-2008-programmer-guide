USE AdventureWorks;
GO

WITH TotalSalesBySalesDatePartitioned
(
	DailySales,
	OrderMonth,
	OrderDate
)
AS
(
	SELECT
		SUM(soh.SubTotal) AS DailySales,
		DATENAME(MONTH, soh.OrderDate) AS OrderMonth,
		soh.OrderDate
	FROM Sales.SalesOrderHeader soh
	WHERE soh.OrderDate >= '20020101'
		AND soh.OrderDate < '20030101'
	GROUP BY soh.OrderDate
)
SELECT
	DENSE_RANK() OVER
	(
		PARTITION BY
			OrderMonth
		ORDER BY
			DailySales DESC
	) AS Ranking,
	DailySales,
	OrderMonth,
	OrderDate
FROM TotalSalesBySalesDatePartitioned
ORDER BY 
	OrderMonth,
	Ranking;
GO