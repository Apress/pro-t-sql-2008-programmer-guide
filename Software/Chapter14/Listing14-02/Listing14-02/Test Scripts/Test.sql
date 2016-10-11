-- Listing 14-3
SELECT 'nospam-123@yahoo.com' AS Email, 
  dbo.EmailMatch (N'nospam-123@yahoo.com') AS Valid
UNION
SELECT '123@456789',
  dbo.EmailMatch('123@456789')
UNION
SELECT 'BillyG@HOTMAIL.COM',
  dbo.EmailMatch('BillyG@HOTMAIL.COM');
