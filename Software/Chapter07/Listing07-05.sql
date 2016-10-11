USE AdventureWorks;
GO

UPDATE HumanResources.Department
SET Name = N'Information Technology'
WHERE DepartmentId = 11;

INSERT INTO HumanResources.Department
(
	Name,
	GroupName
)
VALUES
(
	N'Customer Service',
	N'Sales and Marketing'
);

DELETE
FROM HumanResources.Department
WHERE Name = N'Customer Service';

SELECT
	EntryNum,
	SchemaName,
	TableName,
	ActionType,
	ActionXml,
	UserName,
	Spid,
	ActionDateTime
FROM dbo.DmlActionLog;
GO

