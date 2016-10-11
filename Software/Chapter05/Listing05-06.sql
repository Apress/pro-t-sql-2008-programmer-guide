USE AdventureWorks;
GO

SELECT
	LastName,
	dbo.EncodeNYSIIS(LastName) AS NYSIIS
FROM Person.Person
GROUP BY LastName;
GO