USE AdventureWorks;
GO

WITH Permissions
(
  permission,
  type,
  obj_name,
  db_principal,
  grant_type,
  schema_name
)
AS
(
  SELECT dp.permission_name,
    CASE dp.class_desc
      WHEN 'OBJECT_OR_COLUMN' THEN
        CASE
          WHEN minor_id > 0 THEN 'COLUMN'
          ELSE o.type_desc 
        END
        ELSE dp.class_desc 
      END,
    CASE dp.class_desc
      WHEN 'SCHEMA' THEN SCHEMA_NAME(dp.major_id) 
      WHEN 'OBJECT_OR_COLUMN' THEN
        CASE
          WHEN dp.minor_id = 0 THEN object_name(dp.major_id)
          ELSE
            (
              SELECT object_name(o.object_id) + '.'+ c.name 
              FROM sys.columns c
              WHERE c.object_id = dp.major_id 
                AND c.column_id = dp.minor_id
            )
        END
        ELSE '**UNKNOWN**' 
      END, 
    dpr.name,
    dp.state_desc,
    SCHEMA_NAME(o.schema_id)
  FROM sys.database_permissions dp
  INNER JOIN sys.database_principals dpr
    ON dp.grantee_principal_id = dpr.principal_id
  LEFT JOIN sys.objects o
    ON o.object_id = dp.major_id
  WHERE dp.major_id > 0
)
SELECT 
  p.permission,
  CASE type
    WHEN 'SCHEMA' THEN 'Schema::' + obj_name
    ELSE schema_name + '.' + obj_name
  END AS name,
  p.type,
  p.db_principal,
  p.grant_type
FROM Permissions p
ORDER BY
  p.db_principal,
  p.permission;
GO

