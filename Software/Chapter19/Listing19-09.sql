USE AdventureWorks;
GO

ALTER TABLE Person.Person REBUILD
WITH (DATA_COMPRESSION = PAGE);
GO
