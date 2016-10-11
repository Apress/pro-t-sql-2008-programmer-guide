USE AdventureWorks;
GO

SELECT 
  CustomerID,
  "HL Road Frame - Black, 58",
  "HL Road Frame - Red, 58",
  "HL Road Frame - Red, 62",
  "HL Road Frame - Red, 44",
  "HL Road Frame - Red, 48",
  "HL Road Frame - Red, 52",
  "HL Road Frame - Red, 56",
  "LL Road Frame - Black, 58"
FROM 
(
  SELECT soh.CustomerID, p.Name AS ProductName,
    COUNT
    (
      CASE WHEN sod.LineTotal IS NULL THEN NULL
      ELSE 1 
      END
    ) AS NumberOfItems
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesOrderDetail sod
      ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN Production.Product p
      ON sod.ProductID = p.ProductID
    GROUP BY
      soh.CustomerID,
      sod.ProductID,
      p.Name
) src
PIVOT 
(
  SUM(NumberOfItems) FOR ProductName 
  IN 
  (
    "HL Road Frame - Black, 58",
    "HL Road Frame - Red, 58",
    "HL Road Frame - Red, 62",
    "HL Road Frame - Red, 44",
    "HL Road Frame - Red, 48",
    "HL Road Frame - Red, 52",
    "HL Road Frame - Red, 56",
    "LL Road Frame - Black, 58"
  )
) AS pvt;
GO
