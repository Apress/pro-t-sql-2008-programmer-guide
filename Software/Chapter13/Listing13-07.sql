USE AdventureWorks;
GO

SELECT
  session_id,
  client_net_address,
  auth_scheme,
  net_transport,
  client_tcp_port,
  local_tcp_port,
  connection_id
FROM sys.dm_exec_connections;
GO

