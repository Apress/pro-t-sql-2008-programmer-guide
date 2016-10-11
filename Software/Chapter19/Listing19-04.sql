USE AdventureWorks;
GO

SET STATISTICS IO ON;

SELECT
  Id,
  LastName,
  FirstName,
  MiddleName
FROM dbo.SmallRows;

SELECT
  Id,
  LastName,
  FirstName,
  MiddleName
FROM dbo.LargeRows;
GO
