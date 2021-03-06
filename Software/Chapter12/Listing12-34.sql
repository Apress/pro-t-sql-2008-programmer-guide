USE AdventureWorks;
GO

SELECT CatalogDescription.query
(
  N'declare namespace ns =
  "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
  for $spec in //ns:ProductDescription/ns:Specifications/*
  where $spec[ contains( . , "A" ) ]
  return <detail> 
    {
      $spec/text() 
    } 
  </detail>'
) AS Detail
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO