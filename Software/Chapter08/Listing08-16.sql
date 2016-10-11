USE AdventureWorks;
GO

sp_configure 'show advanced', 1;
GO

RECONFIGURE;
GO

sp_configure 'EKM provider enabled', 1;
GO

RECONFIGURE;
GO
