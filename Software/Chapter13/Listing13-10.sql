USE AdventureWorks;
GO

SELECT
  cpu_count AS logical_CPUs,
  hyperthread_ratio,
  physical_memory_in_bytes / 1048576.00 AS physical_MB, 
  virtual_memory_in_bytes / 1048576.00 AS virtual_MB,
  sqlserver_start_time  
FROM sys.dm_os_sys_info;
GO

