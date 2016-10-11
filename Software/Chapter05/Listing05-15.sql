USE AdventureWorks;
GO

SELECT
	n.Num,
	p.Name,
	p.ProductNumber,
	p.Color,
	p.Size,
	p.SizeUnitMeasureCode,
	p.StandardCost,
	p.ListPrice
FROM Production.Product p
INNER JOIN dbo.GetCommaSplit('FR-R38R-52,FR-M94S-52,FR-M94B-44,BK-M68B-38') n
	ON p.ProductNumber = n.Element;
GO
