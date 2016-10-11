USE AdventureWorks;
GO

-- Create the NYSIIS replacement rules table
CREATE TABLE dbo.NYSIIS_Replacements
(
	Location nvarchar(10) NOT NULL,
	NGram nvarchar(10) NOT NULL,
	Replacement nvarchar(10) NOT NULL,
	PRIMARY KEY (Location, NGram)
);

GO