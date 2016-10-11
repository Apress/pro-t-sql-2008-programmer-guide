USE AdventureWorks;
GO

INSERT INTO HumanResources.Shift
(
	Name,
	StartTime,
	EndTime
)
VALUES
(
	'Noon Part-time',
	'12:00:00',
	'16:00:00'
),
(
	'Evening Part-time',
	'16:00:00',
	'20:00:00'
),
(
	'Midnight Part-time',
	'00:00:00',
	'04:00:00'
);

SELECT
	ShiftID,
	Name,
	StartTime,
	EndTime,
	ModifiedDate
FROM HumanResources.Shift;
GO