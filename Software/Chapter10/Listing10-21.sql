USE AdventureWorks;
GO

SELECT
  keyword,
  group_id,
  phrase_id,
  occurrence,
  special_term,
  display_term,
  expansion_type,
  source_term
FROM sys.dm_fts_parser
(
  N'FORMSOF(FREETEXT, had)',
  1033, 
  NULL, 
  0
);
GO



