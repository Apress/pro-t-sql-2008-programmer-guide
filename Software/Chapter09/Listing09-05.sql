USE AdventureWorks;
GO

DECLARE @ComponentID int = 774;

WITH BillOfMaterialsCTE
(
	BillOfMaterialsID,
	ProductAssemblyID,
	ComponentID,
	Quantity,
	Level
)
AS
(
	SELECT
		bom.BillOfMaterialsID,
		bom.ProductAssemblyID,
		bom.ComponentID,
		bom.PerAssemblyQty AS Quantity,
		0 AS Level
	FROM Production.BillOfMaterials bom
	WHERE bom.ComponentID = @ComponentID

	UNION ALL

	SELECT
		bom.BillOfMaterialsID,
		bom.ProductAssemblyID,
		bom.ComponentID,
		bom.PerAssemblyQty,
		Level + 1
	FROM Production.BillOfMaterials bom
	INNER JOIN BillOfMaterialsCTE bomcte
		ON bom.ProductAssemblyID = bomcte.ComponentID
	WHERE bom.EndDate IS NULL
)
SELECT
	bomcte.ProductAssemblyID,
	p.ProductID,
	p.ProductNumber,
	p.Name,
	p.Color,
	bomcte.Quantity,
	bomcte.Level
FROM BillOfMaterialsCTE bomcte
INNER JOIN Production.Product p
	ON bomcte.ComponentID = p.ProductID;
GO