USE AdventureWorks;
GO

CREATE PROCEDURE HumanResources.GetEmployees
	(@LastNameTable HumanResources.LastNameTableType READONLY)
AS
BEGIN
	SELECT
		p.LastName,
		p.FirstName,
		p.MiddleName,
		e.NationalIDNumber,
		e.Gender,
		e.HireDate
	FROM HumanResources.Employee e
	INNER JOIN Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	INNER JOIN @LastNameTable lnt
		ON p.LastName = lnt.LastName
	ORDER BY
		p.LastName,
		p.FirstName,
		p.MiddleName;
END
GO
