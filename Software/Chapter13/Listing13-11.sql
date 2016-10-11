USE AdventureWorks;
GO

DECLARE @database_name sysname = 'AdventureWorks';

WITH IndexOps
(
  schema_name,
  table_name,
  index_name,
  user_ops
)
AS
(
  SELECT
    OBJECT_SCHEMA_NAME(i.object_id),
    OBJECT_NAME(i.object_id), 
    i.name, 
    COALESCE(s.user_updates + s.user_seeks +
      s.user_scans + s.user_lookups, 0)
  FROM sys.indexes i 
  LEFT JOIN sys.dm_db_index_usage_stats s 
    ON s.object_id = i.object_id 
    AND i.index_id = s.index_id 
  WHERE s.database_id = DB_ID(@database_name)
)
SELECT
  schema_name,
  table_name,
  index_name,
  user_ops
FROM IndexOps
WHERE user_ops = 0
ORDER BY
  schema_name,
  table_name;
GO

