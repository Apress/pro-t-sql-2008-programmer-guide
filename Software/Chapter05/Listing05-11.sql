USE AdventureWorks;
GO

CREATE FUNCTION dbo.GetProductPullList()
RETURNS @result table
(
	SalesOrderID int NOT NULL,
	ProductID int NOT NULL,
	LocationID smallint NOT NULL,
	Shelf nvarchar(10) NOT NULL,
	Bin tinyint NOT NULL,
	QuantityInBin smallint NOT NULL,
	QuantityOnOrder smallint NOT NULL,
	QuantityToPull smallint NOT NULL,
	PartialFillFlag nchar(1) NOT NULL,
	PRIMARY KEY (SalesOrderID, ProductID, LocationID, Shelf, Bin)
)
AS
BEGIN
	INSERT INTO @result
	(
		SalesOrderID,
		ProductID,
		LocationID,
		Shelf,
		Bin,
		QuantityInBin,
		QuantityOnOrder,
		QuantityToPull,
		PartialFillFlag
	)
	SELECT
		Order_Details.SalesOrderID,
		Order_Details.ProductID,
		Inventory_Details.LocationID,
		Inventory_Details.Shelf,
		Inventory_Details.Bin,
		Inventory_Details.Quantity,
		Order_Details.OrderQty,
		COUNT(*) AS PullQty,
		CASE WHEN COUNT(*) < Order_Details.OrderQty
			THEN N'Y'
			ELSE N'N'
			END AS PartialFillFlag
	FROM
	(
		SELECT ROW_NUMBER() OVER
			(
				PARTITION BY p.ProductID
				ORDER BY 
					p.ProductID,
					p.LocationID,
					p.Shelf,
					p.Bin
			) AS Num,
			p.ProductID,
			p.LocationID,
			p.Shelf,
			p.Bin,
			p.Quantity
		FROM Production.ProductInventory p
		INNER JOIN dbo.Numbers n
			ON n.Num BETWEEN 1 AND Quantity
	) Inventory_Details
	INNER JOIN
	(
		SELECT ROW_NUMBER() OVER
			(
				PARTITION BY o.ProductID
				ORDER BY
					o.ProductID,
					o.SalesOrderID
			) AS Num,
			o.ProductID,
			o.SalesOrderID,
			o.OrderQty
		FROM Sales.SalesOrderDetail o
		INNER JOIN dbo.Numbers n
			ON n.Num BETWEEN 1 AND o.OrderQty
	) Order_Details
		ON Inventory_Details.ProductID = Order_Details.ProductID
			AND Inventory_Details.Num = Order_Details.Num
	GROUP BY
		Order_Details.SalesOrderID,
		Order_Details.ProductID,
		Inventory_Details.LocationID,
		Inventory_Details.Shelf,
		Inventory_Details.Bin,
		Inventory_Details.Quantity,
		Order_Details.OrderQty;
	RETURN;
END;
GO
