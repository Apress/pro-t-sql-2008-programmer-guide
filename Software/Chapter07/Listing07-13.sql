USE AdventureWorks;
GO

-- Create a table to log DDL CREATE TABLE actions
CREATE TABLE dbo.DdlActionLog
(
	EntryNum int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	EventType nvarchar(200) NOT NULL,
	PostTime datetime NOT NULL,
	Spid int NOT NULL,
	LoginName sysname NOT NULL,
	UserName sysname NOT NULL,
	ServerName sysname NOT NULL,
	SchemaName sysname NOT NULL,
	DatabaseName sysname NOT NULL,
	ObjectName sysname NOT NULL,
	ObjectType sysname NOT NULL,
	CommandText nvarchar(max) NOT NULL
);
GO

CREATE TRIGGER AuditCreateTable
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
	-- Assign the XML event data to an xml variable
	DECLARE @event_data xml;
	SET @event_data = EVENTDATA();

	-- Shred the XML event data and insert a row in the log table
	INSERT INTO dbo.DdlActionLog
	(
		EventType,
		PostTime,
		Spid,
		LoginName,
		UserName,
		ServerName,
		SchemaName,
		DatabaseName,
		ObjectName,
		ObjectType,
		CommandText
	)
	SELECT
		EventNode.value(N'EventType[1]', N'nvarchar(200)'),
		EventNode.value(N'PostTime[1]', N'datetime'),
		EventNode.value(N'SPID[1]', N'int'),
		EventNode.value(N'LoginName[1]', N'sysname'),
		EventNode.value(N'UserName[1]', N'sysname'),
		EventNode.value(N'ServerName[1]', N'sysname'),
		EventNode.value(N'SchemaName[1]', N'sysname'),
		EventNode.value(N'DatabaseName[1]', N'sysname'),
		EventNode.value(N'ObjectName[1]', N'sysname'),
		EventNode.value(N'ObjectType[1]', N'sysname'),
		EventNode.value(N'(TSQLCommand/CommandText)[1]', 'nvarchar(max)')
	FROM @event_data.nodes('/EVENT_INSTANCE') EventTable(EventNode);
END;
GO

GO

