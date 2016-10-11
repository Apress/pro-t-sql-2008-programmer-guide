USE AdventureWorks;
GO

DECLARE @start_dt2 datetime2 = '1972-07-06T07:13:28.8230234',
	@end_dt2 datetime2 = '2009-12-14T03:14:13.2349832';

SELECT
	@start_dt2 AS start_dt2,
	@end_dt2 AS end_dt2;
GO