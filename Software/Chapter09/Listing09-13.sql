USE AdventureWorks;
GO

SELECT
	pod.PurchaseOrderID,
	pod.ProductID,
	pqty.TotalOrderQty
FROM Purchasing.PurchaseOrderDetail pod
INNER JOIN
(
	SELECT
		ProductID,
		SUM(OrderQty) AS TotalOrderQty
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY ProductID
) pqty
	ON pod.ProductID = pqty.ProductID;
GO