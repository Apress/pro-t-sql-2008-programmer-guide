USE AdventureWorks;
GO

DECLARE @start_dto datetimeoffset = '1492-10-12T13:29:59.9999999-05:00';

SELECT
	@start_dto AS start_dto,
	DATEPART(YEAR, @start_dto) AS start_year;
GO