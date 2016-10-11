USE AdventureWorks;
GO

CREATE PROCEDURE Person.GetTenContacts @RowNum int
AS
BEGIN
	WITH PageContacts AS
	(
		SELECT
			ROW_NUMBER() OVER
			(
				ORDER BY
					LastName,
					FirstName,
					MiddleName
			) AS PosNo,
			LastName,
			FirstName,
			MiddleName
		FROM Person.Person
	)
	SELECT
		PosNo,
		LastName,
		FirstName,
		MiddleName
	FROM PageContacts
	WHERE PosNo BETWEEN @RowNum AND @RowNum + 9;
END;
GO

EXEC Person.GetTenContacts 6100;
GO