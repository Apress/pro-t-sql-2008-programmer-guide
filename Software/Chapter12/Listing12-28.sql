USE AdventureWorks;
GO

DECLARE @x xml = N'';

SELECT @x.query(N'<Name>
    <ID>
      { 
        sql:column("p.BusinessEntityID") 
      }
    </ID>
    <FullName>
      {
        sql:column("p.FirstName"),
        sql:column("p.MiddleName"),
        sql:column("p.LastName") 
      }
    </FullName>
</Name>')
FROM Person.Person p
WHERE p.BusinessEntityID <= 5
ORDER BY p.BusinessEntityID;
GO