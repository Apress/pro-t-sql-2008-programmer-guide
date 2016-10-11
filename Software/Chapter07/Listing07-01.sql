USE AdventureWorks;
GO

CREATE TRIGGER HumanResources.EmployeeUpdateTrigger
ON HumanResources.Employee
AFTER UPDATE
NOT FOR REPLICATION
AS
BEGIN
	-- Get number of affected rows
	DECLARE @Count int = @@ROWCOUNT;

	-- Turn off "rows affected" messages
	SET NOCOUNT ON;

	-- Make sure at least one row was affected
	IF @Count > 0
	BEGIN

		-- Update ModifiedDate for all affected rows
		UPDATE HumanResources.Employee
		SET ModifiedDate = GETDATE()
		WHERE EXISTS
		(
			SELECT 1
			FROM inserted i
			WHERE i.BusinessEntityID = HumanResources.Employee.BusinessEntityID
		);
	END;
END;
GO

