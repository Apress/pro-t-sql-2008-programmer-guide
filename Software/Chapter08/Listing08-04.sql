USE AdventureWorks;
GO

-- Back up DMK
BACKUP MASTER KEY
TO FILE = 'c:\AdventureWorks.DMK'
ENCRYPTION BY PASSWORD = 'p@$$w0rd';

-- Restore DMK from backup
RESTORE MASTER KEY
FROM FILE = 'c:\AdventureWorks.DMK'
DECRYPTION BY PASSWORD = 'p@$$w0rd'
ENCRYPTION BY PASSWORD = '3rt=d4uy';
GO

