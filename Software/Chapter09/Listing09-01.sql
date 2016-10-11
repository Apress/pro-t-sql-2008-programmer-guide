USE AdventureWorks;
GO

WITH GetNamesCTE
(
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName
)
AS
(
	SELECT
		BusinessEntityID,
		FirstName,
		MiddleName,
		LastName
	FROM Person.Person
)
SELECT
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName
FROM GetNamesCTE;
GO