USE master;
GO

CREATE MASTER KEY
	ENCRYPTION BY PASSWORD = 'p@$$w0rd';
GO

CREATE CERTIFICATE ServerCert
	WITH SUBJECT = 'Server Certificate for TDE',
	EXPIRY_DATE = '2022-12-31';
GO
