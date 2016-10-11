USE AdventureWorks;
GO

DECLARE @x xml = '';

SELECT @x.query('(1, <myNode>Testing</myNode>)');
GO