USE AdventureWorks;
GO

CREATE TABLE #t1 
(
  Id int NOT NULL,
  LastName nvarchar(50),
  FirstName nvarchar(50),
  MiddleName nvarchar(50)
);

CREATE INDEX t1_LastName
ON #t1 (LastName);

INSERT INTO #t1
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

SELECT
  BusinessEntityID,
  LastName,
  FirstName,
  MiddleName
FROM #t1
WHERE LastName = N'Duffy';

DROP TABLE #t1;
GO
