USE AdventureWorks;
GO

EXEC sp_estimate_data_compression_savings 'Production',
  'TransactionHistory',
  NULL,
  NULL,
  'ROW';
GO
