USE AdventureWorks;
GO

CREATE TRIGGER HumanResources.DepartmentChangeAudit
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS
BEGIN
	-- Get number of affected rows
	DECLARE @Count int = @@ROWCOUNT;

	-- Make sure at least one row was actually affected
	IF (@Count > 0)
	BEGIN
		-- Turn off "rows affected" messages
		SET NOCOUNT ON;
		DECLARE @ActionType nvarchar(10);
		DECLARE @ActionXml xml;

		-- Get count of inserted rows
		DECLARE @inserted_count int =
		(
			SELECT COUNT(*)
			FROM inserted
		);
		-- Get count of deleted rows
		DECLARE @deleted_count int =
		(
			SELECT COUNT(*)
			FROM deleted
		);

		-- Determine the type of DML action that fired the trigger
		SELECT @ActionType = CASE
			WHEN (@inserted_count > 0) AND (@deleted_count = 0)
				THEN N'insert'
			WHEN (@inserted_count = 0) AND (@deleted_count > 0)
				THEN N'delete'
				ELSE N'update'
			END;

		-- Use FOR XML AUTO to retrieve before and after snapshots of the changed
		-- data in XML format
		SELECT @ActionXml = COALESCE
			(
				(
					SELECT *
					FROM deleted
					FOR XML AUTO
				), N'<deleted/>'
			) + COALESCE
			(
				(
					SELECT *
					FROM inserted
					FOR XML AUTO
				), N'<inserted/>'
			);

		-- Insert a row for the logged action in the audit logging table
		INSERT INTO dbo.DmlActionLog
		(
			SchemaName,
			TableName,
			ActionType,
			ActionXml,
			UserName,
			Spid,
			ActionDateTime
		)
		SELECT
			OBJECT_SCHEMA_NAME(@@PROCID, DB_ID()),
			OBJECT_NAME(t.parent_id, DB_ID()),
			@ActionType,
			@ActionXml,
			USER_NAME(),
			@@SPID,
			GETDATE()
		FROM sys.triggers t
		WHERE t.object_id = @@PROCID;
	END;
END;
GO

