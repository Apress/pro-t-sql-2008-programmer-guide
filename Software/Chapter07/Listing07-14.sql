USE AdventureWorks;
GO

CREATE TABLE dbo.MyTable (i int);
GO

SELECT
	EntryNum,
	EventType,
	UserName,
	ObjectName,
	CommandText
FROM DdlActionLog;
GO

