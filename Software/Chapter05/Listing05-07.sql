USE AdventureWorks;
GO

SELECT
	BusinessEntityID,
	LastName,
	FirstName,
	MiddleName,
	dbo.EncodeNYSIIS(LastName) AS NYSIIS
FROM Person.Person
WHERE dbo.EncodeNYSIIS(LastName) = dbo.EncodeNYSIIS(N'Liu');
GO