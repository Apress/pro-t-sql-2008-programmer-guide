USE AdventureWorks;
GO

BEGIN TRY
	INSERT INTO Person.Contact
	(
		ContactID,
		FirstName,
		LastName
	)
	VALUES
	(
		10,
		'Joe',
		'Louis'
	);
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS "@Number",
		ERROR_STATE() AS "@State",
		ERROR_SEVERITY() AS "@Severity",
		ERROR_MESSAGE() AS "Message",
		ERROR_LINE() AS "Procedure/@Line",
		ERROR_PROCEDURE() AS "Procedure"
	FOR XML PATH('Error');
END CATCH
GO
