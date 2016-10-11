USE AdventureWorks;
GO

-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'P@55w0rd';

-- Create asymmetric key
CREATE ASYMMETRIC KEY TestAsymmetricKey
WITH ALGORITHM = RSA_512;

-- Assign a credit card number to encrypt
DECLARE @CreditCard nvarchar(26) = N'9000 1234 5678 9012';
SELECT @CreditCard;

-- Encrypt the credit card number
DECLARE @EncryptedCreditCard varbinary(64) =
	EncryptByAsymKey(AsymKey_ID(N'TestAsymmetricKey'), @CreditCard);

SELECT @EncryptedCreditCard;

-- Decrypt the encrypted credit card number
DECLARE @DecryptedCreditCard nvarchar(26) =
	DecryptByAsymKey(AsymKey_ID(N'TestAsymmetricKey'), @EncryptedCreditCard);

SELECT @DecryptedCreditCard;

-- Drop asymmetric key
DROP ASYMMETRIC KEY TestAsymmetricKey;

-- Drop DMK
DROP MASTER KEY;
GO

