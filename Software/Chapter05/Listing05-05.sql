USE AdventureWorks;
GO

CREATE FUNCTION dbo.EncodeNYSIIS
(
	@String nvarchar(100)
)
RETURNS nvarchar(6)
WITH RETURNS NULL ON NULL INPUT
AS
BEGIN
	DECLARE @Result nvarchar(100);
	SET @Result = UPPER(@String);

	-- Step 1: Remove all nonalphabetic characters
	WITH Numbers (Num)
	AS
	(
		SELECT 1

		UNION ALL

		SELECT Num + 1
		FROM Numbers
		WHERE Num < LEN(@Result)
	)
	SELECT @Result = STUFF
	(
		@Result,
		Num,
		1,
		CASE WHEN SUBSTRING(@Result, Num, 1) >= N'A'
				AND SUBSTRING(@Result, Num, 1) <= N'Z'
			THEN SUBSTRING(@Result, Num, 1)
			ELSE N'.'
			END
	)
	FROM Numbers;

	SET @Result = REPLACE(@Result, N'.', N'');

	-- Step 2: Replace the start n-gram
	SELECT TOP (1) @Result = STUFF
	(
		@Result,
		1,
		LEN(NGram),
		Replacement
	)
	FROM dbo.NYSIIS_Replacements
	WHERE Location = N'Start'
		AND SUBSTRING(@Result, 1, LEN(NGram)) = NGram
	ORDER BY LEN(NGram) DESC;

	-- Step 3: Replace the end n-gram
	SELECT TOP (1) @Result = STUFF
	(
		@Result,
		LEN(@Result) - LEN(NGram) + 1,
		LEN(NGram),
		Replacement
	)
	FROM dbo.NYSIIS_Replacements
	WHERE Location = N'End'
		AND SUBSTRING(@Result, LEN(@Result) - LEN(NGram) + 1, LEN(NGram)) = NGram
	ORDER BY LEN(NGram) DESC;

	-- Step 4: Save the first letter of the name
	DECLARE @FirstLetter nchar(1);
	SET @FirstLetter = SUBSTRING(@Result, 1, 1);

	-- Step 5: Replace all middle n-grams
	DECLARE @Replacement nvarchar(10);

	DECLARE @i int;
	SET @i = 1;
	WHILE @i <= LEN(@Result)
	BEGIN
		SET @Replacement = NULL;

		-- Grab the middle-of-name replacement n-gram
		SELECT TOP (1) @Replacement = Replacement
		FROM dbo.NYSIIS_Replacements
		WHERE Location = N'Mid'
			AND SUBSTRING(@Result, @i, LEN(NGram)) = NGram
		ORDER BY LEN(NGram) DESC;

		SET @Replacement = COALESCE(@Replacement, SUBSTRING(@Result, @i, 1));

		-- If we found a replacement, apply it
		SET @Result = STUFF(@Result, @i, LEN(@Replacement), @Replacement);

		-- Move on to the next n-gram
		SET @i = @i + COALESCE(LEN(@Replacement), 1);
	END;

	-- Replace the first character with the first letter we saved at the start
	SET @Result = STUFF(@Result, 1, 1, @FirstLetter);

	-- Here we apply our special rules for the 'H' character. Special handling for
	-- 'W' characters is taken care of in the replacement rules table
	WITH Numbers (Num)
	AS
	(
		SELECT 2 -- Don't bother with the first character
		UNION ALL
		SELECT Num + 1
		FROM Numbers
		WHERE Num < LEN(@Result)
	)
	SELECT @Result = STUFF
	(
		@Result,
		Num,
		1,
		CASE SUBSTRING(@Result, Num, 1)
			WHEN N'H' THEN
				CASE WHEN SUBSTRING(@Result, Num + 1, 1) NOT IN (N'A', N'E', N'I', N'O', N'U')
						OR SUBSTRING(@Result, Num - 1, 1) NOT IN (N'A', N'E', N'I', N'O', N'U')
					THEN SUBSTRING(@Result, Num - 1, 1)
					ELSE N'H'
					END
				ELSE SUBSTRING(@Result, Num, 1)
				END
	)
	FROM Numbers;

	-- Step 6: Reduce all side-by-side duplicate characters
	-- First replace the first letter of any sequence of two side-by-side
	-- duplicate letters with a period
	WITH Numbers (Num)
	AS
	(
		SELECT 1

		UNION ALL

		SELECT Num + 1
		FROM Numbers
		WHERE Num < LEN(@Result)
	)
	SELECT @Result = STUFF
	(
		@Result,
		Num,
		1,
		CASE SUBSTRING(@Result, Num, 1)
			WHEN SUBSTRING(@Result, Num + 1, 1) THEN N'.'
			ELSE SUBSTRING(@Result, Num, 1)
			END
	)
	FROM Numbers;

	-- Next replace all periods '.' with an empty string ''
	SET @Result = REPLACE(@Result, N'.', N'');

	-- Step 7: Remove trailing 'S' characters
	WHILE RIGHT(@Result, 1) = N'S' AND LEN(@Result) > 1
		SET @Result = STUFF(@Result, LEN(@Result), 1, N'');

	-- Step 8: Remove trailing 'A' characters
	WHILE RIGHT(@Result, 1) = N'A' AND LEN(@Result) > 1
		SET @Result = STUFF(@Result, LEN(@Result), 1, N'');

	-- Step 9: Replace trailing 'AY' characters with 'Y'
	IF RIGHT(@Result, 2) = 'AY'
		SET @Result = STUFF(@Result, LEN(@Result) - 1, 1, N'');

	-- Step 10: Truncate result to 6 characters
	RETURN COALESCE(SUBSTRING(@Result, 1, 6), '');
END;
GO