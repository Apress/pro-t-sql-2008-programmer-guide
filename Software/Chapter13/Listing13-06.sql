USE AdventureWorks;
GO

SELECT
   login_name,
   SUM(cpu_time) AS tot_cpu_time,
   SUM(memory_usage) AS tot_memory_usage,
   AVG(total_elapsed_time) AS avg_elapsed_time,
   SUM(reads) AS tot_reads,
   SUM(writes) AS tot_writes,
   SUM(logical_reads) AS tot_logical_reads,
   COUNT(session_id) as tot_sessions
 FROM sys.dm_exec_sessions 
 WHERE session_id > 50
 GROUP BY login_name;
GO

