USE AdventureWorks;
GO

CREATE SYNONYM Folks
FOR AdventureWorks.Person.Person;

SELECT
  LastName,
  FirstName,
  MiddleName
FROM Folks;

GO
