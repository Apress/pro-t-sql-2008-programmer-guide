USE AdventureWorks;
GO

CREATE TABLE dbo.SmallRows 
(
  Id int NOT NULL,
  LastName nchar(50) NOT NULL,
  FirstName nchar(50) NOT NULL,
  MiddleName nchar(50) NULL
);

INSERT INTO dbo.SmallRows 
(
  Id,
  LastName,
  FirstName,
  MiddleName
)
SELECT
  BusinessEntityID,
  LastName,
  FirstName,
  MiddleName
FROM Person.Person;
GO
