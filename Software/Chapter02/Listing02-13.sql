USE AdventureWorks;
GO

SELECT
	BomNode,
	BomNode.ToString(),
	ProductAssemblyID,
	ComponentID,
	UnitMeasureCode,
	PerAssemblyQty,
	BomLevel
FROM Production.HierBillOfMaterials
ORDER BY BomNode;
GO
