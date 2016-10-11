USE AdventureWorks;
GO

CREATE USER jill 
WITHOUT LOGIN;

CREATE USER jack 
WITHOUT LOGIN;

GRANT SELECT, INSERT 
ON Schema::HumanResources TO jill;

GRANT SELECT 
ON dbo.ufnGetContactInformation TO jill;

GRANT EXECUTE 
ON HumanResources.uspUpdateEmployeeLogin TO jill;

DENY SELECT 
ON Schema::Sales TO jill;

DENY SELECT 
ON HumanResources.Shift (ModifiedDate) TO jill;

GRANT SELECT, UPDATE, INSERT, DELETE 
ON Schema::Production TO jack WITH GRANT OPTION;
GO
