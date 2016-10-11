USE AdventureWorks;
GO
DECLARE @docHandle int;

DECLARE @xmlDocument nvarchar(max) = N'<Customers>
    <Customer CustomerID="1234" ContactName="Larry" CompanyName="APress">
       <Orders>
           <Order CustomerID="1234" OrderDate="2006-04-25T13:22:18"/>
           <Order CustomerID="1234" OrderDate="2006-05-10T12:35:49"/>
       </Orders>
    </Customer>
    <Customer CustomerID="4567" ContactName="Bill" CompanyName="Microsoft">
       <Orders>
           <Order CustomerID="4567" OrderDate="2006-03-12T18:32:39"/>
           <Order CustomerID="4567" OrderDate="2006-05-11T17:56:12"/>
       </Orders>
    </Customer>
</Customers>';

EXECUTE sp_xml_preparedocument @docHandle OUTPUT, @xmlDocument;

CREATE TABLE #CustomerInfo 
(
  CustomerID nchar(4) NOT NULL,
  ContactName nvarchar(50) NOT NULL,
  CompanyName nvarchar(50) NOT NULL
);

CREATE TABLE #OrderInfo
(
  CustomerID nchar(4) NOT NULL,
  OrderDate datetime NOT NULL
);

INSERT INTO #CustomerInfo
(
  CustomerID,
  ContactName,
  CompanyName
)
SELECT 
  CustomerID, 
  ContactName, 
  CompanyName
FROM OPENXML(@docHandle, N'/Customers/Customer')
WITH #CustomerInfo;

INSERT INTO #OrderInfo
(
  CustomerID,
  OrderDate
)
SELECT
  CustomerID,
  OrderDate
FROM OPENXML(@docHandle, N'//Order')
WITH #OrderInfo;

SELECT
  c.CustomerID,
  c.ContactName,
  c.CompanyName,
  o.OrderDate
FROM #CustomerInfo c
INNER JOIN #OrderInfo o
  ON c.CustomerID = o.CustomerID;

DROP TABLE #OrderInfo;
DROP TABLE #CustomerInfo;

EXECUTE sp_xml_removedocument @docHandle;
GO




