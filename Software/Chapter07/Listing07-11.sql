USE AdventureWorks;
GO

UPDATE Sales.vIndividualCustomer
SET
	FirstName = N'Dave',
	MiddleName = N'Robert',
	EmailAddress = N'dave.robinett@adventure-works.com'
WHERE BusinessEntityID = 1699;

GO

