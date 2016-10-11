USE AdventureWorks;
GO

DECLARE @current datetime = '2008-02-14 10:00:00';
SELECT @current AS "No_Offset";
SELECT TODATETIMEOFFSET(@current, '-04:00') AS "With_Offset";
GO
