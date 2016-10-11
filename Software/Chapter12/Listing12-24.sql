USE AdventureWorks;
GO

DECLARE @x xml = '';

SELECT @x.query('(xs:date("2006-10-09"), 6.02E23) > xs:date("2007-01-01")');
GO