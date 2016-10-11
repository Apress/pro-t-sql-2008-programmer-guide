USE AdventureWorks;
GO

WITH CustomersByRegion(Region)
AS
(
SELECT
	CASE sp.StateProvinceCode
		WHEN 'CA' THEN 'West Coast'
		WHEN 'WA' THEN 'West Coast'
		WHEN 'OR' THEN 'West Coast'
		ELSE 'Elsewhere'
		END
	FROM Sales.CustomerAddress a
	INNER JOIN Person.Address p
		ON a.AddressID = p.AddressID
	INNER JOIN Person.StateProvince sp
		ON p.StateProvinceID = p.StateProvinceID
	WHERE sp.CountryRegionCode = 'US'
)
SELECT
	COUNT(Region) AS NumOfCustomers,
	Region
FROM CustomersByRegion
GROUP BY Region;
GO
