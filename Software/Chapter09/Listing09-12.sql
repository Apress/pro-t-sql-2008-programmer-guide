USE AdventureWorks;
GO

SELECT
	PurchaseOrderID,
	ProductID,
	SUM(OrderQty) OVER
	(
		PARTITION BY
			ProductId
	) AS TotalOrderQty
FROM Purchasing.PurchaseOrderDetail;
GO