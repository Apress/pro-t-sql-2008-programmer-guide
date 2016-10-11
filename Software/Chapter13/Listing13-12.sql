USE AdventureWorks;
GO

SELECT
  c.Column_Name,
  c.Ordinal_Position
FROM Information_Schema.Columns c
WHERE c.Table_Schema = 'Person'
  AND c.Table_Name = 'Person'
ORDER BY c.Ordinal_Position;
GO

