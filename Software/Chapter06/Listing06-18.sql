USE AdventureWorks;
GO

ALTER PROCEDURE Sales.GetSalesBySalesPerson (@SalesPersonId int)
AS
BEGIN
	SELECT
		soh.SalesOrderID,
		soh.OrderDate,
		soh.TotalDue
	FROM Sales.SalesOrderHeader soh
	WHERE soh.SalesPersonID = @SalesPersonId
	OPTION (RECOMPILE);
END
GO

