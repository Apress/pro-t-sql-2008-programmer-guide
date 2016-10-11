USE AdventureWorks;
GO

SELECT
	gn.BusinessEntityID,
	gn.FirstName,
	gn.MiddleName,
	gn.LastName,
	gn.Email,
	gn.HomePhoneNumber
FROM
(
	SELECT
		p.BusinessEntityID,
		p.FirstName,
		p.MiddleName,
		p.LastName,
		ea.Email,
		ea.HomePhoneNumber
	FROM Person.Person p
	LEFT JOIN
	(
		SELECT
			ea.BusinessEntityID,
			ea.Email,
			pp.HomePhoneNumber
		FROM Person.EmailAddress ea
		LEFT JOIN
		(
			SELECT
				pp.BusinessEntityID,
				pp.PhoneNumber AS HomePhoneNumber,
				pp.PhoneNumberTypeID
			FROM Person.PersonPhone pp
			) pp
				ON ea.BusinessEntityID = pp.BusinessEntityID
					AND pp.PhoneNumberTypeID = 2
		) ea
			ON p.BusinessEntityID = ea.BusinessEntityID
) gn;
GO