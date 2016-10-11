USE AdventureWorks;
GO

-- Windows environment variable
SELECT '$(PATH)';

-- SQLCMD scripting variable
SELECT '$(SQLCMDSERVER)';

-- Command-line scripting variable -v COLVAR= "Name" switch
SELECT $(COLVAR)
FROM Sys.Tables;
GO
