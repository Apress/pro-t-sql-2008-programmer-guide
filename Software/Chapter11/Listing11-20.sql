USE AdventureWorks;
GO

DECLARE @xml xml = 
(
  SELECT
    p.ProductNumber AS "@Id",
    p.Name AS "Name",
    p.Color AS "Color",
    p.ListPrice AS "ListPrice",
    p.SizeUnitMeasureCode AS "Size/@UOM",
    p.Size AS "Size",
    p.WeightUnitMeasureCode AS "Weight/@UOM",
    p.Weight AS "Weight",
    (
      SELECT COALESCE(SUM(i.Quantity), 0)
      FROM Production.ProductInventory i
      WHERE i.ProductID = p.ProductID
    ) AS "QuantityOnHand"
  FROM Production.Product p
  WHERE p.FinishedGoodsFlag = 1
  ORDER BY p.Name
  FOR XML PATH ('Product'),
    ROOT ('Products')
);
GO





