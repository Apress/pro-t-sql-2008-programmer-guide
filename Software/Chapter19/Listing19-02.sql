USE AdventureWorks;
GO

SELECT
  sys.fn_PhysLocFormatter(%%physloc%%) AS [Row_Locator],
  Id
FROM dbo.SmallRows;
GO
