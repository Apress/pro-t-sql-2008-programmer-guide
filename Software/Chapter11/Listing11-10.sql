USE AdventureWorks;
GO

DECLARE @x XML;
CREATE TABLE XmlPurchaseOrders
(
  PoNum int NOT NULL PRIMARY KEY,
  XmlPurchaseOrder xml
);
GO




