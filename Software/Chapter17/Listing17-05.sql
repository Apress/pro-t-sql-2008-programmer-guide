USE AdventureWorks;
GO

CREATE TABLE #AuditPriceChange
(
  ProductID int NOT NULL PRIMARY KEY,
  OldListPrice money NOT NULL,
  NewListPrice money NOT NULL
);

INSERT INTO #AuditPriceChange
(
  ProductID,
  OldListPrice,
  NewListPrice
)
SELECT
  s.ProductID,
  s.OldListPrice,
  s.NewListPrice
FROM
(
  UPDATE Production.Product
  SET ListPrice = ListPrice + (ListPrice * 0.20)
  OUTPUT
    inserted.ProductID AS ProductID,
    deleted.ListPrice AS OldListPrice,
    inserted.ListPrice AS NewListPrice
) s
WHERE s.NewListPrice > 500.0;

SELECT
  ProductID,
  OldListPrice,
  NewListPrice 
FROM #AuditPriceChange
ORDER BY NewListPrice;

DROP TABLE #AuditPriceChange;
GO
