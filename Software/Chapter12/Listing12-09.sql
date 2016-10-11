USE AdventureWorks;
GO

SELECT Resume.query
(
  N'//*:Name.First,
  //*:Name.Middle,
  //*:Name.Last,
  //*:Edu.Level'
)
FROM HumanResources.JobCandidate;
GO