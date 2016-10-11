USE AdventureWorks;
GO

CREATE TABLE Production.Document
(
  DocumentNode    hierarchyid NOT NULL PRIMARY KEY,
  DocumentLevel   AS (DocumentNode.GetLevel()),
  Title           nvarchar(50) NOT NULL,
  Owner           int NOT NULL,
  FolderFlag      bit NOT NULL,
  FileName        nvarchar(400) NOT NULL,
  FileExtension   nvarchar(8) NOT NULL,
  Revision        nchar(5) NOT NULL,
  ChangeNumber    int NOT NULL,
  Status          tinyint NOT NULL,
  DocumentSummary nvarchar(max) NULL,
  Document        varbinary(max) FILESTREAM  NULL,
  rowguid         uniqueidentifier ROWGUIDCOL  NOT NULL,
  ModifiedDate    datetime NOT NULL
);
GO
