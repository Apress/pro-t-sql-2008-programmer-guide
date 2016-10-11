USE AdventureWorks;
GO

EXEC sp_estimate_data_compression_savings 'Person',
  'Person',
  NULL,
  NULL,
  'PAGE';
GO
