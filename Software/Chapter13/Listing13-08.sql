USE AdventureWorks;
GO

SELECT 
  r.session_id,
  r.command,
  t.text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t;
GO

