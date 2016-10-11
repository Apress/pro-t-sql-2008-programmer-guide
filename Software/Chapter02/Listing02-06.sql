USE AdventureWorks;
GO

CREATE TABLE #TempShifts
(
	Name varchar(50) NOT NULL,
	StartTime time NOT NULL,
	EndTime time NOT NULL,
	Action varchar(10) NOT NULL
);
GO
INSERT INTO #TempShifts
(
	Name,
	StartTime,
	EndTime,
	Action
)
VALUES
(
	'Morning Part-time',
	'08:00:00',
	'12:00:00',
	'DELETE'
),
(
	'Evening Part-time ',
	'18:00:00',
	'22:00:00',
	'UPDATE'
),
(
	'Midnight Swing Shift',
	'00:00:00',
	'04:00:00',
	'DELETE'
);
MERGE HumanResources.Shift AS target
USING #TempShifts AS source
	ON (target.Name = source.Name)
		OR (target.StartTime = source.StartTime
			AND target.EndTime = source.EndTime)
WHEN MATCHED AND (source.Action = 'Delete') THEN
	DELETE
WHEN MATCHED THEN
	UPDATE
		SET 
			Name = source.Name,
			StartTime = source.StartTime,
			EndTime = source.EndTime
WHEN TARGET NOT MATCHED THEN
	INSERT
	(
		Name,
		StartTime,
		EndTime
	)
	VALUES
	(
		source.Name,
		source.StartTime,
		source.EndTime
	);

SELECT
	ShiftID,
	Name,
	StartTime,
	EndTime,
	ModifiedDate
FROM HumanResources.Shift;
GO

DROP TABLE #TempShifts;
GO