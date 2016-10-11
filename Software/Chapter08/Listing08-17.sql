USE AdventureWorks;
GO

CREATE CRYPTOGRAPHIC PROVIDER Eagle_EKM_Provider
	FROM FILE = 'c:\Program Files\Eagle_EKM\SQLEKM.DLL';
GO
