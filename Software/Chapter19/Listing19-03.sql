USE AdventureWorks;
GO

CREATE TABLE dbo.LargeRows 
(
  Id int NOT NULL,
  LastName nchar(600) NOT NULL,
  FirstName nchar(600) NOT NULL,
  MiddleName nchar(600) NULL
);

INSERT INTO dbo.LargeRows 
(
  Id,
  LastName,
  FirstName,
  MiddleName
)
SELECT
  BusinessEntityID,
  LastName,
  FirstName,
  MiddleName
FROM Person.Person;

SELECT
  sys.fn_PhysLocFormatter(%%physloc%%) AS [Row_Locator],
  Id
FROM dbo.SmallRows;
GO
