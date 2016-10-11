USE AdventureWorks;
GO

ALTER PROCEDURE Production.GetProductsByName
	@Prefix NVARCHAR(100)
AS
BEGIN
	DECLARE @PrefixVar NVARCHAR(100) = @Prefix;

	SELECT
		p.Name,
		p.ProductID
	FROM Production.Product p
	WHERE p.Name LIKE @PrefixVar;
END
GO

