USE AdventureWorks;
GO

CREATE TABLE Person.ContactNYSIIS
(
	BusinessEntityID int NOT NULL,
	NYSIIS nvarchar(6) NOT NULL,
	PRIMARY KEY(NYSIIS, ContactId)
);
GO

INSERT INTO Person.ContactNYSIIS
(
	BusinessEntityID,
	NYSIIS
)
SELECT
	BusinessEntityID,
	dbo.EncodeNYSIIS(LastName)
FROM Person.Person;
GO
