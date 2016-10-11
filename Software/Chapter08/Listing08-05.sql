USE AdventureWorks;
GO

CREATE CERTIFICATE TestCertificate
ENCRYPTION BY PASSWORD = 'p@$$w0rd'
WITH SUBJECT = 'Adventureworks Test Certificate',
EXPIRY_DATE = '2026-10-31';
GO

