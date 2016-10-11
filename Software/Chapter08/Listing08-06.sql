USE AdventureWorks;
GO

BACKUP CERTIFICATE TestCertificate
	TO FILE = 'c:\TestCertificate.CER'
	WITH PRIVATE KEY
	(
		FILE = 'c:\TestCertificate.PVK',
		ENCRYPTION BY PASSWORD = '7&rt0xp2',
		DECRYPTION BY PASSWORD = 'p@$$w0rd'
	);
GO

