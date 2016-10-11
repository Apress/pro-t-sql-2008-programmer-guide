USE AdventureWorks;
GO

WITH CustomersByRegion(Region)
AS
(
SELECT
	CASE WHEN sp.StateProvinceCode IN ('CA', 'WA', 'OR') THEN 'West Coast'
		WHEN sp.StateProvinceCode IN ('HI', 'AK') THEN 'Pacific'
		WHEN sp.StateProvinceCode IN ('CT', 'MA', 'ME', 'NH', 'RI', 'VT')
		THEN 'New England'
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
	COUNT(*) AS NumOfCustomers,
	Region
FROM CustomersByRegion
GROUP BY Region;
GO
