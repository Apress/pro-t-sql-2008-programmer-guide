USE AdventureWorks;
GO

CREATE TABLE NonSparseTable
(
  CustomerID int NOT NULL PRIMARY KEY,
  "HL Road Frame - Black, 58" int NULL,
  "HL Road Frame - Red, 58" int NULL,
  "HL Road Frame - Red, 62" int NULL,
  "HL Road Frame - Red, 44" int NULL,
  "HL Road Frame - Red, 48" int NULL,
  "HL Road Frame - Red, 52" int NULL,
  "HL Road Frame - Red, 56" int NULL,
  "LL Road Frame - Black, 58" int NULL
);

CREATE TABLE SparseTable
(
  CustomerID int NOT NULL PRIMARY KEY,
  "HL Road Frame - Black, 58" int SPARSE NULL,
  "HL Road Frame - Red, 58" int SPARSE NULL,
  "HL Road Frame - Red, 62" int SPARSE NULL,
  "HL Road Frame - Red, 44" int SPARSE NULL,
  "HL Road Frame - Red, 48" int SPARSE NULL,
  "HL Road Frame - Red, 52" int SPARSE NULL,
  "HL Road Frame - Red, 56" int SPARSE NULL,
  "LL Road Frame - Black, 58" int SPARSE NULL
);
GO
