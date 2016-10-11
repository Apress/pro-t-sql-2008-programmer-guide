USE AdventureWorks;
GO

SELECT
  d.Title,
  d.Document.PathName() AS BLOB_Path,
  d.Document AS BLOB_Data
FROM Production.Document d
WHERE d.Document IS NOT NULL;
GO
