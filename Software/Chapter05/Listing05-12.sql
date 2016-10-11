USE AdventureWorks;
GO

SELECT
	p.Name AS ProductName,
	p.ProductNumber,
	p.Color,
	ppl.SalesOrderID,
	ppl.ProductID,
	ppl.LocationID,
	ppl.Shelf,
	ppl.Bin,
	ppl.QuantityInBin,
	ppl.QuantityOnOrder,
	ppl.QuantityToPull,
	ppl.PartialFillFlag
FROM Production.Product p
INNER JOIN dbo.GetProductPullList() ppl
	ON p.ProductID = ppl.ProductID;
GO
