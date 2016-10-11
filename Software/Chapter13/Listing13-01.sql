USE AdventureWorks;
GO

SELECT
  s.name AS schema_name,
  t.name AS table_name,
  t.type_desc AS table_type,
  c.name AS column_name,
  c.column_id,
  ty.name AS data_type_name,
  c.max_length,
  c.precision,
  c.scale,
  c.is_nullable
FROM sys.schemas s
INNER JOIN sys.tables t
  ON s.schema_id = t.schema_id
INNER JOIN sys.columns c
  ON t.object_id = c.object_id
INNER JOIN sys.types ty
  ON c.system_type_id = ty.system_type_id
    AND c.user_type_id = ty.user_type_id
WHERE s.name = 'Person'
  AND t.name = 'Address';
GO