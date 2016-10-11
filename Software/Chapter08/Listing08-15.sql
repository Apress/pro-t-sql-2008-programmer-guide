USE AdventureWorks;
GO

DECLARE @cleartext nvarchar(256);
DECLARE @encrypted varbinary(512);
DECLARE @decrypted nvarchar(256);

SELECT @cleartext = N'To be, or not to be: that is the question: ' +
	N'Whether ''tis nobler in the mind to suffer ' +
	N'The slings and arrows of outrageous fortune, ' +
	N'Or to take arms against a sea of troubles';

SELECT @encrypted = EncryptByPassPhrase(N'Shakespeare''s Donkey', @cleartext);

SELECT @decrypted = CAST
	(
		DecryptByPassPhrase(N'Shakespeare''s Donkey', @encrypted)
		AS nvarchar(128)
	);

SELECT @cleartext AS ClearText;

SELECT @encrypted AS Encrypted;

SELECT @decrypted AS Decrypted;

SELECT HashBytes ('SHA1', @ClearText) AS Hashed;
GO
