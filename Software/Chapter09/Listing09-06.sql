USE AdventureWorks;
GO

SELECT
	ROW_NUMBER() OVER
	(
		PARTITION BY
			LastName
		ORDER BY
			LastName,
			FirstName,
			MiddleName
	) AS Number,
	LastName,
	FirstName,
	MiddleName
FROM Person.Person;
GO