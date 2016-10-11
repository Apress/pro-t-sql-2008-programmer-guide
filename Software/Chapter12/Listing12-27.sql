USE AdventureWorks;
GO

DECLARE @x xml = N'<?xml version = "1.0"?>
<Root>
    <NodeA>Test Node</NodeA>
</Root>';

SELECT @x.query('((/Root/NodeA)[1] << (/Root/NodeZ)[1])   (: empty sequence :)');
GO