USE AdventureWorks;
GO

CREATE PROCEDURE Production.GetProductsByName
	@Prefix NVARCHAR(100)
AS
BEGIN
	SELECT
		p.Name,
		p.ProductID
	FROM Production.Product p
	WHERE p.Name LIKE @Prefix;
END
GO

