USE AdventureWorks;
GO

CREATE PROCEDURE dbo.RebuildIndexes
AS
BEGIN
  SET NOCOUNT ON;
  
  CREATE TABLE #table_list
  (
    id int NOT NULL IDENTITY (1, 1) PRIMARY KEY,
    [schema_name] sysname,
    [table_name] sysname
  );

  INSERT INTO #table_list
  (
    [schema_name],
    [table_name]
  )
  SELECT
    SCHEMA_NAME(t.schema_id) AS [schema_name], 
    t.name AS [table_name]
  FROM sys.tables t
  INNER JOIN sys.indexes i
    ON t.object_id = i.object_id
  WHERE t.type_desc = 'USER_TABLE'
    AND i.type_desc IN ('CLUSTERED', 'NONCLUSTERED');

  DECLARE @id int =
  (
    SELECT MIN(id)
    FROM #table_list
  );
  
  DECLARE @sqlcmd nvarchar(max);

  WHILE (@id IS NOT NULL)
  BEGIN

    SELECT @sqlcmd = 'ALTER INDEX ALL ON [' + [schema_name] + '].[' +
      [table_name] + '] REBUILD;'
    FROM #table_list
    WHERE id = @id;

    PRINT @sqlcmd;

    EXEC (@sqlcmd);

    SELECT @id = MIN(id)
    FROM #table_list
    WHERE id > @id;

  END;

  SELECT
    id,
    [schema_name],
    [table_name]
  FROM #table_list;

  DROP TABLE #table_list;
END
GO

EXEC dbo.RebuildIndexes;
GO
