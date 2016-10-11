USE AdventureWorks;
GO

SELECT
  SERVERPROPERTY('ServerName') AS Server_Name,
  SERVERPROPERTY('FilestreamSharename') AS Share_Name,
  CASE SERVERPROPERTY('FilestreamEffectiveLevel')
    WHEN 0 THEN 'Disabled'
    WHEN 1 THEN 'T-SQL Access Only'
    WHEN 2 THEN 'Local T-SQL/File System Access Only'
    WHEN 3 THEN 'Local T-SQL/File System and Remote File System Access'
    END AS Effective_Level,
  CASE SERVERPROPERTY('FilestreamConfiguredLevel')
    WHEN 0 THEN 'Disabled'
    WHEN 1 THEN 'T-SQL Access Only'
    WHEN 2 THEN 'Local T-SQL/File System Access Only'
    WHEN 3 THEN 'Local T-SQL/File System and Remote File System Access'
    END AS Configured_Level;
GO
