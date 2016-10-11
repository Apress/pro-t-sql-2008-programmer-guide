USE AdventureWorks;
GO

WITH BomChildren
(
	ProductAssemblyID,
	ComponentID
)
AS
(
	SELECT
		b1.ProductAssemblyID,
		b1.ComponentID
	FROM Production.BillOfMaterials b1
	GROUP BY
		b1.ProductAssemblyID,
		b1.ComponentID
),
BomPaths
(
	Path,
	ComponentID,
	ProductAssemblyID
)
AS
(
	SELECT
		hierarchyid::GetRoot() AS Path,
		NULL,
		NULL

	UNION ALL

	SELECT
		CAST
		(
			'/' +
				CAST
				(
					bc.ComponentId AS varchar(30)
				) +
			'/' AS hierarchyid
		) AS Path,
		bc.ComponentID,
		bc.ProductAssemblyID
	FROM BomChildren AS bc
	WHERE bc.ProductAssemblyID IS NULL

	UNION ALL

	SELECT
		CAST
		(
		bp.path.ToString() +
			CAST
			(
				bc.ComponentID AS varchar(30)
			) +
		'/' AS hierarchyid
		) AS Path,
		bc.ComponentID,
		bc.ProductAssemblyID
	FROM BomChildren AS bc
	INNER JOIN BomPaths AS bp
		ON bc.ProductAssemblyID = bp.ComponentID
)
INSERT INTO Production.HierBillOfMaterials
(
	BomNode,
	ProductAssemblyID,
	ComponentID,
	UnitMeasureCode,
	PerAssemblyQty
)
SELECT
	bp.Path,
	bp.ProductAssemblyID,
	bp.ComponentID,
	bom.UnitMeasureCode,
	bom.PerAssemblyQty
FROM BomPaths AS bp
LEFT OUTER JOIN Production.BillOfMaterials bom
	ON bp.ComponentID = bom.ComponentID
		AND COALESCE(bp.ProductAssemblyID, -1) = COALESCE(bom.ProductAssemblyID, -1)
WHERE bom.EndDate IS NULL
GROUP BY
	bp.path,
	bp.ProductAssemblyID,
	bp.ComponentID,
	bom.UnitMeasureCode,
	bom.PerAssemblyQty;
GO
