USE AdventureWorks;
GO

WITH SalesTotalBySalesPerson
(
	SalesPersonID,
	SalesTotal
)
AS
(
	SELECT
		soh.SalesPersonID,
		SUM(soh.SubTotal) AS SalesTotal
	FROM Sales.SalesOrderHeader soh
	WHERE DATEPART(YEAR, soh.OrderDate) = 2003
	GROUP BY soh.SalesPersonID
)
SELECT
	NTILE(10) OVER
		(
			ORDER BY
				st.SalesTotal DESC
		) AS Tile,
	p.LastName,
	p.FirstName,
	p.MiddleName,
	st.SalesPersonID,
	st.SalesTotal
FROM SalesTotalBySalesPerson st
INNER JOIN Person.Person p
	ON st.SalesPersonID = p.BusinessEntityID;
GO