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
),
GetContactCTE
(
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName,
	Email,
	HomePhoneNumber
)
AS
(
	SELECT
		gn.BusinessEntityID,
		gn.FirstName,
		gn.MiddleName,
		gn.LastName,
		ea.EmailAddress,
		pp.PhoneNumber
	FROM GetNamesCTE gn
	LEFT JOIN Person.EmailAddress ea
		ON gn.BusinessEntityID = ea.BusinessEntityID
	LEFT JOIN Person.PersonPhone pp
		ON gn.BusinessEntityID = pp.BusinessEntityID
			AND pp.PhoneNumberTypeID = 2
)
SELECT
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName,
	Email,
	HomePhoneNumber
FROM GetContactCTE;
GO