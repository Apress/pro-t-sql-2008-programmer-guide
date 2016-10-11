USE AdventureWorks;
GO

-- Turn off messages that can affect performance
SET NOCOUNT ON;

-- Create and initially populate a test table
CREATE TABLE #test 
(
  Id int NOT NULL PRIMARY KEY,
  String varchar(max) NOT NULL
);

INSERT INTO #test
(
  Id,
  String
)
VALUES
(
  1,
  ''
),
(
  2,
  ''
);

-- Initialize variables and get start time
DECLARE @i int = 1;
DECLARE @quote varchar(50) = 'Four score and seven years ago...';
DECLARE @start_time datetime2(7) = SYSDATETIME();

-- Loop 2500 times and use .WRITE to append to a varchar(max) column
WHILE @i < 2500
BEGIN
  UPDATE #test
  SET string.WRITE(@quote, LEN(string), LEN(@quote))
  WHERE Id = 1;

  SET @i += 1;
END;

SELECT '.WRITE Clause', DATEDIFF(ms, @start_time, SYSDATETIME()), 'ms';

-- Reset variables and get new start time
SET @i = 1;
SET @start_time = SYSDATETIME();

-- Loop 2500 times and use string append to a varchar(max) column
WHILE @i < 2500
BEGIN
  UPDATE #test
  SET string += @quote
  WHERE Id = 2;

  SET @i += 1;
END;

SELECT 'Append Method', DATEDIFF(ms, @start_time, SYSDATETIME()), 'ms';

SELECT
  Id,
  String, 
  LEN(String)
FROM #test;

DROP TABLE #test;
GO
