USE AdventureWorks;
GO

CREATE PROCEDURE Person.SearchByLastName
(
  @LastName nvarchar(50)
)
AS
BEGIN
  SELECT
    LastName,
    FirstName,
    MiddleName
  FROM Person.Person
  WHERE LastName LIKE @LastName + N'%'
END
GO

EXEC dbo.sp_reserve_http_namespace N'http://SQL2008:2008/AdvPersonSearch'
GO

CREATE ENDPOINT AdvPersonSearch
  STATE = STARTED
AS HTTP
(
  PATH = N'/AdvPersonSearch',
  AUTHENTICATION = (INTEGRATED),
  PORTS = (CLEAR),
  CLEAR_PORT = 2008,
  SITE = N'SQL2008'
)
FOR SOAP
(
  WEBMETHOD N'SearchByLastName'
  (
    NAME = N'AdventureWorks.Person.SearchByLastName',
    FORMAT = ROWSETS_ONLY
  ),
  WSDL = DEFAULT,
  DATABASE = N'AdventureWorks',
  SCHEMA = STANDARD
);
GO
