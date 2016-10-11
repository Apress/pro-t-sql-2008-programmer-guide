USE AdventureWorks;
GO

CREATE FUNCTION dbo.GetCommaSplit (@String nvarchar(max))
RETURNS table
AS
RETURN
(
	WITH Splitter (Num, String)
	AS
	(
		SELECT Num, SUBSTRING
			(
				@String,
				Num,
				CASE CHARINDEX(N',', @String, Num)
					WHEN 0 THEN LEN(@String) - Num + 1
					ELSE CHARINDEX(N',', @String, Num) - Num
					END
			) AS String
		FROM dbo.Numbers
		WHERE Num <= LEN(@String)
			AND (SUBSTRING(@String, Num - 1, 1) = N',' OR Num = 0)
	)
	SELECT
		ROW_NUMBER() OVER (ORDER BY Num) AS Num,
		RTRIM(LTRIM(String)) AS Element
	FROM Splitter
	WHERE String <> ''
);
GO
GO
