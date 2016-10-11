USE AdventureWorks;
GO

CREATE TABLE Production.HierBillOfMaterials
(
	BomNode hierarchyid NOT NULL PRIMARY KEY NONCLUSTERED,
	ProductAssemblyID int NULL,
	ComponentID int NULL,
	UnitMeasureCode nchar(3) NULL,
	PerAssemblyQty decimal(8, 2) NULL,
	BomLevel AS BomNode.GetLevel()
);

GO