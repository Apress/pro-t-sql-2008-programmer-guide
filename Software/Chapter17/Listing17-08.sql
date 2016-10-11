USE AdventureWorks;
GO

CREATE FUNCTION dbo.fnPowers (@Num INT)
RETURNS TABLE
AS
RETURN
(
  SELECT
    @Num * @Num AS Squared_Result,
    @Num * @Num * @Num AS Cubed_Result
);
GO

WITH Numbers (Number)
AS
(
  SELECT 1
  UNION
  SELECT 2
  UNION
  SELECT 3
)
SELECT n.Number,
  s.Squared_Result,
  s.Cubed_Result
FROM Numbers n
CROSS APPLY dbo.fnPowers (n.Number) s;
GO

DROP FUNCTION dbo.fnPowers;
GO
