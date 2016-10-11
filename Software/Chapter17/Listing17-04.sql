USE AdventureWorks;
GO

INSERT INTO HumanResources.Shift 
(
  [Name],
  StartTime,
  EndTime
)
OUTPUT 
  'INSERTED',
  CURRENT_USER,
  inserted.ShiftID
SELECT 
  N'Swing Shift', 
  '12:00:00 PM', 
  '8:00:00 PM';

DELETE FROM HumanResources.Shift
OUTPUT
  'DELETED',
  CURRENT_USER,
  deleted.ShiftID
WHERE [Name] = N'Swing Shift';
GO
