USE AdventureWorks;
GO

-- Create a DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'P@55w0rd';

-- Create a certificate
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = N'Adventureworks Test Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create the plain text data to encrypt
DECLARE @plaintext nvarchar(58) =
N'This is a test string to encrypt';
SELECT 'Plain text = ', @plaintext;

-- Encrypt the plain text by certificate
DECLARE @ciphertext varbinary(128) =
EncryptByCert(Cert_ID('TestCertificate'), @plaintext);
SELECT 'Cipher text = ', @ciphertext;

-- Decrypt the cipher text by certificate
DECLARE @decryptedtext nvarchar(58) =
DecryptByCert(Cert_ID('TestCertificate'), @ciphertext);
SELECT 'Decrypted text = ', @decryptedtext;

-- Drop the test certificate
DROP CERTIFICATE TestCertificate;

-- Drop the DMK
DROP MASTER KEY;

GO

