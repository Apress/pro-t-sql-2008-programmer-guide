USE AdventureWorks;
GO

ALTER TRIGGER Sales.vIndividualCustomerUpdate
ON Sales.vIndividualCustomer
INSTEAD OF UPDATE
NOT FOR REPLICATION
AS
BEGIN
	-- First make sure at least one row was affected
	IF (@@ROWCOUNT > 0)
	BEGIN
		-- Turn off "rows affected" messages
		SET NOCOUNT ON;

		-- Initialize a flag to indicate update success
		DECLARE @UpdateSuccessful nchar(1) = N'N';

		-- Check for updatable columns in the first table
		IF UPDATE(FirstName) OR UPDATE(MiddleName) OR UPDATE(LastName)
		BEGIN
			-- Update columns in the base table
			UPDATE Person.Person
			SET
				FirstName = i.FirstName,
				MiddleName = i.MiddleName,
				LastName = i.LastName
			FROM inserted i
			WHERE i.BusinessEntityID = Person.Person.BusinessEntityID;

			-- Set flag to indicate success
			SET @UpdateSuccessful = N'Y';
		END;

		-- If updatable columns from the second table were specified, update those
		-- columns in the base table
		IF UPDATE(EmailAddress)
		BEGIN
			-- Update columns in the base table
			UPDATE Person.EmailAddress
			SET EmailAddress = i.EmailAddress
			FROM inserted i
			WHERE i.BusinessEntityID = Person.EmailAddress.BusinessEntityID;

			-- Set flag to indicate success
			SET @UpdateSuccessful = N'Y';
		END;

		-- If the update was not successful, raise an error and roll back the
		-- transaction
		IF @UpdateSuccessful = N'N'
			RAISERROR('Must specify updatable columns.', 10, 127);
	END;
END;
GO

