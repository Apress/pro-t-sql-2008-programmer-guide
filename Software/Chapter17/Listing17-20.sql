USE AdventureWorks;
GO

CREATE DATABASE AdventureWorks
(
  NAME = N'AdventureWorks2008_Data', 
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\~CCC
    MSSQL\DATA\AdventureWorks2008.mdf'
), 
FILEGROUP DocumentFileStreamGroup CONTAINS FILESTREAM  
DEFAULT 
(
  NAME = N'FileStreamDocuments', 
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\~CCC
    MSSQL\DATA\AdventureWorks2008_2.Documents' 
)
LOG ON 
(
  NAME = N'AdventureWorks2008_Log', 
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\~CCC
    MSSQL\DATA\AdventureWorks2008_1.ldf' 
);
GO
