USE AdventureWorks;
GO

CREATE FUNCTION dbo.EmailMatch (@input nvarchar(4000))
RETURNS bit 
WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME RegexUDF.[Apress.Examples.UDFExample].EmailMatch
GO


