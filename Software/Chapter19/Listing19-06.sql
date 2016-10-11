USE AdventureWorks;
GO

ALTER TABLE Production.TransactionHistory REBUILD
WITH (DATA_COMPRESSION = ROW);
GO
