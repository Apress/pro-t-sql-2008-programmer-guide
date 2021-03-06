USE AdventureWorks;
GO

OPEN SYMMETRIC KEY TestSymmetricKey
	DECRYPTION BY PASSWORD = 'pa55w0rd';
	ALTER SYMMETRIC KEY TestSymmetricKey
	ADD ENCRYPTION BY CERTIFICATE TestCertificate;

ALTER SYMMETRIC KEY TestSymmetricKey
	DROP ENCRYPTION BY PASSWORD = 'pa55w0rd';

CLOSE SYMMETRIC KEY TestSymmetricKey;
GO
