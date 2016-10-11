USE AdventureWorks;
GO

UPDATE Production.Product
SET 
	Size = N'600',
	SizeUnitMeasureCode = N'MM'
WHERE ProductId = 680;

UPDATE Production.Product
SET 
	Size = N'22.85',
	SizeUnitMeasureCode = N'IN'
WHERE ProductId = 706;

SELECT 
	ProductID,
	Name,
	ProductNumber,
	Size,
	SizeUnitMeasureCode
FROM Production.Product
WHERE ProductID IN (680, 706);
GO

