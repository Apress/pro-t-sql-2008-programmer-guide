USE AdventureWorks;
GO

-- This stored procedure displays all the discs in the appropriate
-- towers.
CREATE PROCEDURE dbo.ShowTowers
AS
BEGIN
	-- Each disc is displayed like this "===3===" where the number is the disc
	-- and the width of the === signs on either side indicates the width of the
	-- disc.

	-- These CTEs are designed for displaying the discs in proper order on each
	-- tower.
	WITH FiveNumbers(Num) -- Recursive CTE generates table with numbers 1...5
	AS
	(
		SELECT 1

		UNION ALL

		SELECT Num + 1
		FROM FiveNumbers
		WHERE Num < 5
	),
	GetTowerA (Disc) -- The discs for Tower A
	AS
	(
		SELECT COALESCE(a.Disc, -1) AS Disc
		FROM FiveNumbers f
		LEFT JOIN #TowerA a
			ON f.Num = a.Disc
	),
	GetTowerB (Disc) -- The discs for Tower B
	AS
	(
		SELECT COALESCE(b.Disc, -1) AS Disc
		FROM FiveNumbers f
		LEFT JOIN #TowerB b
			ON f.Num = b.Disc
	),
	GetTowerC (Disc) -- The discs for Tower C
	AS
	(
		SELECT COALESCE(c.Disc, -1) AS Disc
		FROM FiveNumbers f
		LEFT JOIN #TowerC c
			ON f.Num = c.Disc
	)
	-- This SELECT query generates the text representation for all three towers
	-- and all five discs. FULL OUTER JOIN is used to represent the towers in a
	-- side-by-side format.
	SELECT CASE a.Disc
			WHEN 5 THEN ' =====5===== '
			WHEN 4 THEN '  ====4====  '
			WHEN 3 THEN '   ===3===   '
			WHEN 2 THEN '    ==2==    '
			WHEN 1 THEN '     =1=     '
			ELSE '      |      '
			END AS Tower_A,
		CASE b.Disc
			WHEN 5 THEN ' =====5===== '
			WHEN 4 THEN '  ====4====  '
			WHEN 3 THEN '   ===3===   '
			WHEN 2 THEN '    ==2==    '
			WHEN 1 THEN '     =1=     '
			ELSE '      |      '
			END AS Tower_B,
		CASE c.Disc
			WHEN 5 THEN ' =====5===== '
			WHEN 4 THEN '  ====4====  '
			WHEN 3 THEN '   ===3===   '
			WHEN 2 THEN '    ==2==    '
			WHEN 1 THEN '     =1=     '
			ELSE'      |      '
			END AS Tower_C
	FROM 
	(
		SELECT ROW_NUMBER() OVER(ORDER BY Disc) AS Num,
		COALESCE(Disc, -1) AS Disc
		FROM GetTowerA
	) a
	FULL OUTER JOIN 
	(
		SELECT ROW_NUMBER() OVER(ORDER BY Disc) AS Num,
		COALESCE(Disc, -1) AS Disc
		FROM GetTowerB
	) b
		ON a.Num = b.Num
	FULL OUTER JOIN 
	(
		SELECT ROW_NUMBER() OVER(ORDER BY Disc) AS Num,
		COALESCE(Disc, -1) AS Disc
		FROM GetTowerC
	) c
		ON b.Num = c.Num
	ORDER BY a.Num;
END;
GO

-- This SP moves a single disc from the specified source tower to the
-- specified destination tower.
CREATE PROCEDURE dbo.MoveOneDisc 
(
	@Source nchar(1),
	@Dest nchar(1)
)
AS
BEGIN
	-- @SmallestDisc is the smallest disc on the source tower
	DECLARE @SmallestDisc int = 0;

	-- IF ... ELSE conditional statement gets the smallest disc from the
	-- correct source tower
	IF @Source = N'A'
	BEGIN
		-- This gets the smallest disc from Tower A
		SELECT @SmallestDisc = MIN(Disc)
		FROM #TowerA;

		-- Then delete it from Tower A
		DELETE FROM #TowerA
		WHERE Disc = @SmallestDisc;
	END
	ELSE IF @Source = N'B'
	BEGIN
		-- This gets the smallest disc from Tower B
		SELECT @SmallestDisc = MIN(Disc)
		FROM #TowerB;

		-- Then delete it from Tower B
		DELETE FROM #TowerB
		WHERE Disc = @SmallestDisc;
	END
	ELSE IF @Source = N'C'
	BEGIN
		-- This gets the smallest disc from Tower C
		SELECT @SmallestDisc = MIN(Disc)
		FROM #TowerC;

		-- Then delete it from Tower C
		DELETE FROM #TowerC
		WHERE Disc = @SmallestDisc;
	END
	-- Show the disc move performed
	SELECT N'Moving Disc (' + CAST(COALESCE(@SmallestDisc, 0) AS nchar(1)) +
		N') from Tower ' + @Source + N' to Tower ' + @Dest + ':' AS Description;

	-- Perform the move - INSERT the disc from the source tower into the
	-- destination tower
	IF @Dest = N'A'
		INSERT INTO #TowerA (Disc) VALUES (@SmallestDisc);
	ELSE IF @Dest = N'B'
		INSERT INTO #TowerB (Disc) VALUES (@SmallestDisc);
	ELSE IF @Dest = N'C'
		INSERT INTO #TowerC (Disc) VALUES (@SmallestDisc);

	-- Show the towers
	EXECUTE dbo.ShowTowers;
END;
GO

-- This SP moves multiple discs recursively
CREATE PROCEDURE dbo.MoveDiscs 
(
	@DiscNum int,
	@MoveNum int OUTPUT,
	@Source nchar(1) = N'A',
	@Dest nchar(1) = N'C',
	@Aux nchar(1) = N'B'
)
AS
BEGIN
	-- If the number of discs to move is 0, the solution has been found
	IF @DiscNum = 0
		PRINT N'Done';
	ELSE
	BEGIN
		-- If the number of discs to move is 1, go ahead and move it
		IF @DiscNum = 1
		BEGIN
			-- Increase the move counter by 1
			SELECT @MoveNum += 1;

			-- And finally move one disc from source to destination
			EXEC dbo.MoveOneDisc @Source, @Dest;
		END
		ELSE
		BEGIN
			-- Determine number of discs to move from source to auxiliary tower
			DECLARE @n int = @DiscNum - 1;

			-- Move (@DiscNum - 1) discs from source to auxiliary tower
			EXEC dbo.MoveDiscs @n, @MoveNum OUTPUT, @Source, @Aux, @Dest;

			-- Move 1 disc from source to final destination tower
			EXEC dbo.MoveDiscs 1, @MoveNum OUTPUT, @Source, @Dest, @Aux;

			-- Move (@DiscNum - 1) discs from auxiliary to final destination tower
			EXEC dbo.MoveDiscs @n, @MoveNum OUTPUT, @Aux, @Dest, @Source;
		END;
	END;
END;
GO

-- This SP creates the three towers and populates Tower A with 5 discs
CREATE PROCEDURE dbo.SolveTowers
AS
BEGIN
	-- SET NOCOUNT ON to eliminate system messages that will clutter up
	-- the Message display
	SET NOCOUNT ON;

	-- Create the three towers: Tower A, Tower B, and Tower C
	CREATE TABLE #TowerA (Disc int PRIMARY KEY NOT NULL);
	CREATE TABLE #TowerB (Disc int PRIMARY KEY NOT NULL);
	CREATE TABLE #TowerC (Disc int PRIMARY KEY NOT NULL);

	-- Populate Tower A with all five discs
	INSERT INTO #TowerA (Disc)
	VALUES (1), 
		(2), 
		(3), 
		(4), 
		(5);

	-- Initialize the move number to 0
	DECLARE @MoveNum int = 0;

	-- Show the initial state of the towers
	EXECUTE dbo.ShowTowers;

	-- Solve the puzzle. Notice you don't need to specify the parameters
	-- with defaults
	EXECUTE dbo.MoveDiscs 5, @MoveNum OUTPUT;

	-- How many moves did it take?
	PRINT N'Solved in ' + CAST (@MoveNum AS nvarchar(10)) + N' moves.';

	-- Drop the temp tables to clean up - always a good idea.
	DROP TABLE #TowerC;
	DROP TABLE #TowerB;
	DROP TABLE #TowerA;

	-- SET NOCOUNT OFF before we exit
	SET NOCOUNT OFF;
END;
GO

-- Solve the puzzle
EXECUTE dbo.SolveTowers;
GO
