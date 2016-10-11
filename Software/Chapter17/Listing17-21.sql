USE AdventureWorks;
GO

ALTER DATABASE AdventureWorks
ADD FILEGROUP DocumentFileStreamGroup CONTAINS FILESTREAM;
GO

ALTER DATABASE AdventureWorks
ADD FILE
(
  NAME = N'FileStreamDocuments',
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008_2.Documents' 
)
TO FILEGROUP DocumentFileStreamGroup;
GO
