USE AdventureWorks;
GO

SELECT
  session_id,
  host_name,
  program_name,
  client_interface_name,
  login_name,
  cpu_time,
  ansi_nulls,
  ansi_padding	
FROM sys.dm_exec_sessions;
GO

