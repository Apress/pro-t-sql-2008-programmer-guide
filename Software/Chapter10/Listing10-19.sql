USE AdventureWorks;
GO

ALTER FULLTEXT STOPLIST AWStoplist
ADD N'instructions' LANGUAGE English;
GO

ALTER FULLTEXT INDEX ON Production.ProductModel
SET STOPLIST AWStoplist;
GO



