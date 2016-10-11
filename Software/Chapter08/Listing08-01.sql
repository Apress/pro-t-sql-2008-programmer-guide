USE AdventureWorks;
GO

-- Back up the SMK to a file
BACKUP SERVICE MASTER KEY TO FILE = 'c:\SQL2008.SMK'
ENCRYPTION BY PASSWORD = 'p@$$w0rd';

-- Restore the SMK from a file
RESTORE SERVICE MASTER KEY FROM FILE = 'c:\SQL2008.SMK'
DECRYPTION BY PASSWORD = 'p@$$w0rd';
GO
