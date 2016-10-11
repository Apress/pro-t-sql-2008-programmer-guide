USE AdventureWorks;
GO

SELECT o.name
FROM sys.objects o,
	sys.views v
WHERE o.object_id *= v.object_id;
GO