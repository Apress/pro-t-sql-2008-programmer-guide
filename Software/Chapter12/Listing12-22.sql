USE AdventureWorks;
GO

DECLARE @x xml = N'';

SELECT @x.query(N'3.141592 eq "Pi"') ;
GO