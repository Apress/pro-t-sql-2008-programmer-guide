USE AdventureWorks;
GO

-- August 19, 14 C.E.
DECLARE @d1 date = '0014-08-19';

-- February 26, 1983
DECLARE @d2 date = '1983-02-26';

SELECT
	@d1 AS Date1,
	@d2 AS Date2,
	DATEDIFF(YEAR, @d1, @d2) AS YearsDifference;
GO