USE AdventureWorks;
GO

-- 6:25:19.1 AM
DECLARE @start_time time(1) = '06:25:19.1'; -- 1 digit fractional precision

-- 6:25:19.1234567 PM
DECLARE @end_time time = '18:25:19.1234567'; -- default fractional precision

SELECT
	@start_time AS start_time,
	@end_time AS end_time,
	DATEADD(HOUR, 6, @start_time) AS StartTimePlus,
	DATEDIFF(HOUR, @start_time, @end_time) AS EndStartDiff;
GO