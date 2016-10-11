USE AdventureWorks;
GO

DECLARE @product_name nvarchar(50) = N'Mountain';
CREATE FUNCTION dbo.ValidateString (@string nvarchar(4000))
RETURNS int
AS
BEGIN
  DECLARE @result int = 0;
  WITH Numbers (Num)
  AS
  (
    SELECT 1
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num <= LEN(@string)
  )
  SELECT @result = SUM 
  (
    CASE 
      WHEN SUBSTRING(@string, n.Num, 1) LIKE N'[A-Z0-9\_]' ESCAPE '\'
        THEN 0
        ELSE 1 
        END
  )
  FROM Numbers n
  WHERE n.Num <= LEN(@string)
  OPTION (MAXRECURSION 0);
  RETURN @result;
END
GO
