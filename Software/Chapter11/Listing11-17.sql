USE AdventureWorks;
GO

DECLARE @x xml = N'<?xml version="1.0" ?>
<Address>
  <Street>1 MICROSOFT WAY</Street>
  <City>REDMOND</City>
  <State>WA</State>
  <Zip>98052</Zip>
  <Country>US</Country>
  <Website>http://www.microsoft.com</Website>
</Address>';

SELECT @x;

SET @x.modify ('insert
(
  <CompanyName>Microsoft Corporation</CompanyName>,
  <Url>http://msdn.microsoft.com</Url>,
  <UrlDescription>Microsoft Developer Network</UrlDescription>
)
into (/Address)[1] ');

SET @x.modify('replace value of
  (/Address/Street/text())[1]
  with "ONE MICROSOFT WAY"
');

SET @x.modify('
  delete /Address/Website
');

SELECT @x;
GO





