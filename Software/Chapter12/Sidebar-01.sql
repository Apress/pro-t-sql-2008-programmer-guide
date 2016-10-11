USE AdventureWorks;
GO

DECLARE @x xml;
SET @x = N'<a>123<b>456</b><c>789</c></a><a>987<b>654</b><c>321</c></a>';

SELECT @x.query('/a/text()');

SELECT @x.query('data(/a)');

SELECT @x.query('string(/a[1])');
GO