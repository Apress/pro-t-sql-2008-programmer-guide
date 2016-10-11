USE AdventureWorks;
GO

CREATE TABLE Production.SparseProduct
(
  ProductID int NOT NULL PRIMARY KEY,
  Name dbo.Name NOT NULL,
  ProductNumber nvarchar(25) NOT NULL,
  Color nvarchar(15) SPARSE NULL,
  Size nvarchar(5) SPARSE NULL,
  SizeUnitMeasureCode nchar(3) SPARSE NULL,
  WeightUnitMeasureCode nchar(3) SPARSE NULL,
  Weight decimal(8, 2) SPARSE NULL,
  Class nchar(2) SPARSE NULL,
  Style nchar(2) SPARSE NULL,
  SellStartDate datetime NOT NULL,
  SellEndDate datetime SPARSE NULL,
  DiscontinuedDate datetime SPARSE NULL,
  SparseColumnSet xml COLUMN_SET FOR ALL_SPARSE_COLUMNS
);
GO

INSERT INTO Production.SparseProduct
(
  ProductID,
  Name,
  ProductNumber,
  Color,
  Size,
  SizeUnitMeasureCode,
  WeightUnitMeasureCode,
  Weight,
  Class,
  Style,
  SellStartDate,
  SellEndDate,
  DiscontinuedDate
)
SELECT
  ProductID,
  Name,
  ProductNumber,
  Color,
  Size,
  SizeUnitMeasureCode,
  WeightUnitMeasureCode,
  Weight,
  Class,
  Style,
  SellStartDate,
  SellEndDate,
  DiscontinuedDate
FROM Production.Product;
GO

