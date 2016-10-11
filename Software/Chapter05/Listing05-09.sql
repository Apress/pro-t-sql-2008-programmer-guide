USE AdventureWorks;
GO

SELECT
	cn.BusinessEntityID,
	c.LastName,
	c.FirstName,
	c.MiddleName,
	cn.NYSIIS
FROM Person.ContactNYSIIS cn
INNER JOIN Person.Person c
	ON cn.BusinessEntityID = c.BusinessEntityID
WHERE cn.NYSIIS = dbo.EncodeNYSIIS(N'Liu');
GO
