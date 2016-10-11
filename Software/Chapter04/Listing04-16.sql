USE AdventureWorks;
GO

CREATE PROCEDURE dbo.RebuildIndexes
	@ShowOrRebuild nvarchar(10) = N'show',
	@MaxFrag decimal(20, 2) = 20.0
AS
BEGIN
	-- Declare variables
	SET NOCOUNT ON;
	DECLARE
		@Schema nvarchar(128),
		@Table nvarchar(128),
		@Index nvarchar(128),
		@Sql nvarchar(4000),
		@DatabaseId int,
		@SchemaId int,
		@TableId int,
		@IndexId int;

	-- Create the index list table
	DECLARE @IndexList TABLE
	(
		DatabaseName nvarchar(128) NOT NULL,
		DatabaseId int NOT NULL,
		SchemaName nvarchar(128) NOT NULL,
		SchemaId int NOT NULL,
		TableName nvarchar(128) NOT NULL,
		TableId int NOT NULL,
		IndexName nvarchar(128),
		IndexId int NOT NULL,
		Fragmentation decimal(20, 2),
		PRIMARY KEY (DatabaseId, SchemaId, TableId, IndexId)
	);

	-- Populate index list table
	INSERT INTO @IndexList
	(
		DatabaseName,
		DatabaseId,
		SchemaName,
		SchemaId,
		TableName,
		TableId,
		IndexName,
		IndexId,
		Fragmentation
	)
	SELECT
		db_name(),
		db_id(),
		s.Name,
		s.schema_id,
		t.Name,
		t.object_id,
		i.Name,
		i.index_id,
		MAX(ip.avg_fragmentation_in_percent)
	FROM sys.tables t
	INNER JOIN sys.schemas s
		ON t.schema_id = s.schema_id
	INNER JOIN sys.indexes i
		ON t.object_id = i.object_id
	INNER JOIN sys.dm_db_index_physical_stats (db_id(), NULL, NULL, NULL, NULL) ip
		ON ip.object_id = t.object_id
			AND ip.index_id = i.index_id
	WHERE ip.database_id = db_id()
	GROUP BY
		s.Name,
		s.schema_id,
		t.Name,
		t.object_id,
		i.Name,
		i.index_id;

	-- If user specified rebuild, use a cursor to loop through all indexes and
	-- rebuild them
	IF @ShowOrRebuild = N'rebuild'
	BEGIN
		-- Declare a cursor to create the dynamic SQL statements
		DECLARE Index_Cursor CURSOR FAST_FORWARD
		FOR SELECT 
			SchemaName, 
			TableName, 
			IndexName
		FROM @IndexList
		WHERE Fragmentation > @MaxFrag
		ORDER BY 
			Fragmentation DESC, 
			TableName ASC, 
			IndexName ASC;

		-- Open the cursor for reading
		OPEN Index_Cursor;
		-- Loop through all the tables in the database
		FETCH NEXT 
		FROM Index_Cursor
		INTO
			@Schema, 
			@Table, 
			@Index;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Create ALTER INDEX statement to rebuild index
			SET @Sql = N'ALTER INDEX ' +
				QUOTENAME(RTRIM(@Index)) + N' ON ' + QUOTENAME(@Schema) + N'.' +
				QUOTENAME(RTRIM(@Table)) + N' REBUILD WITH (ONLINE = OFF); ';
			PRINT @Sql;

			-- Execute dynamic SQL
			EXEC (@Sql);

			-- Get the next index
			FETCH NEXT 
			FROM Index_Cursor
			INTO 
				@Schema, 
				@Table, 
				@Index;
		END

		-- Close and deallocate the cursor.
		CLOSE Index_Cursor;
		DEALLOCATE Index_Cursor;
	END

	-- Show results, including old fragmentation and new fragmentation
	-- after index rebuild
	SELECT
		il.DatabaseName,
		il.SchemaName,
		il.TableName,
		il.IndexName,
		il.Fragmentation AS FragmentationStart,
		MAX
		(
			CAST(ip.avg_fragmentation_in_percent AS DECIMAL(20, 2))
		) AS FragmentationEnd
	FROM @IndexList il
	INNER JOIN sys.dm_db_index_physical_stats (@DatabaseId, NULL, NULL, NULL, NULL) ip
		ON DatabaseId = ip.database_id
			AND TableId = ip.object_id
			AND IndexId = ip.index_id
	GROUP BY
		il.DatabaseName,
		il.SchemaName,
		il.TableName,
		il.IndexName,
		il.Fragmentation
	ORDER BY
		Fragmentation DESC,
		TableName ASC,
		IndexName ASC;
	RETURN;
END
GO

-- Execute index rebuild stored procedure
EXEC dbo.RebuildIndexes N'rebuild', 30;
GO
