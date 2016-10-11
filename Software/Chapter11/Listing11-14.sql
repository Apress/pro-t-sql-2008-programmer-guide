USE AdventureWorks;
GO

SELECT Resume.value (N'declare namespace ns =
  "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
  (/ns:Resume/ns:Name/ns:Name.Last)[1]',
  'nvarchar(100)') AS [LastName]
FROM HumanResources.JobCandidate;

GO





