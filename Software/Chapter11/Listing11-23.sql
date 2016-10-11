USE AdventureWorks;
GO

EXECUTE XmlToHtml @xml,
  @xslt,
  'c:\Documents and Settings\All Users\Documents\adventureworks-inventory.html';

GO





