USE AdventureWorks;
GO

CREATE TABLE dbo.DmlActionLog
(
	EntryNum int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	SchemaName sysname NOT NULL,
	TableName sysname NOT NULL,
	ActionType nvarchar(10) NOT NULL,
	ActionXml xml NOT NULL,
	UserName nvarchar(256) NOT NULL,
	Spid int NOT NULL,
	ActionDateTime datetime NOT NULL DEFAULT (GETDATE())
);
GO

