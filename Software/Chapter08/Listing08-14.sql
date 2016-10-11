USE AdventureWorks;
GO

-- Create a temporary table to hold results
CREATE TABLE #TempNames
(
	BusinessEntityID int PRIMARY KEY,
	FirstName nvarchar(50),
	MiddleName nvarchar(50),
	LastName nvarchar(50),
	EncFirstName varbinary(200),
	EncMiddleName varbinary(200),
	EncLastName varbinary(200)
);

-- Create DMK
CREATE MASTER KEY
	ENCRYPTION BY PASSWORD = 'Test_P@ssw0rd';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
	WITH SUBJECT = 'AdventureWorks Test Certificate',
	EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
	WITH ALGORITHM = AES_128
	ENCRYPTION BY CERTIFICATE TestCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
	DECRYPTION BY CERTIFICATE TestCertificate;

-- Populate temp table with 100 encrypted names from the Person.Person table
INSERT
INTO #TempNames
(
	BusinessEntityID,
	EncFirstName,
	EncMiddleName,
	EncLastName
)
SELECT TOP(100)
	BusinessEntityID,
	EncryptByKey(Key_GUID(N'TestSymmetricKey'), FirstName),
	EncryptByKey(Key_GUID(N'TestSymmetricKey'), MiddleName),
	EncryptByKey(Key_GUID(N'TestSymmetricKey'), LastName)
FROM Person.Person
ORDER BY BusinessEntityID;

-- Update the temp table with decrypted names
UPDATE #TempNames
SET
	FirstName = DecryptByKey(EncFirstName),
	MiddleName = DecryptByKey(EncMiddleName),
	LastName = DecryptByKey(EncLastName);

-- Show the results
SELECT
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName,
	EncFirstName,
	EncMiddleName,
	EncLastName
FROM #TempNames;

-- Close the symmetric key
CLOSE SYMMETRIC KEY TestSymmetricKey;

-- Drop the symmetric key
DROP SYMMETRIC KEY TestSymmetricKey;

-- Drop the certificate
DROP CERTIFICATE TestCertificate;

-- Drop the DMK
DROP MASTER KEY;

-- Drop the temp table
DROP TABLE #TempNames;
GO
