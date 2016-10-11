USE AdventureWorks;
GO

DECLARE @current datetimeoffset = '2008-05-23 19:30:00 -07:00';

SELECT 
  'Los Angeles' AS "Location",
  @current AS "Current Time"
UNION
SELECT
  'New York',
  SWITCHOFFSET(@current, '-04:00')
UNION
SELECT
  'Bermuda',
  SWITCHOFFSET(@current, '-03:00')
UNION
SELECT
  'London',
  SWITCHOFFSET(@current, '+01:00');
GO
