USE AdventureWorks;
GO

CREATE TRIGGER Production.ProductEnforceStandardSizes
ON Production.Product
AFTER INSERT, UPDATE
NOT FOR REPLICATION
AS
BEGIN
	-- Make sure at least one row was affected and either the Size or
	-- SizeUnitMeasureCode column was changed
	IF (@@ROWCOUNT > 0)
		AND (UPDATE(SizeUnitMeasureCode) OR UPDATE(Size))
	BEGIN
		-- Eliminate "rows affected" messages
		SET NOCOUNT ON;

		-- Only accept recognized units of measure or NULL
		IF EXISTS
		(
			SELECT 1
			FROM inserted
			WHERE NOT
			(
				SizeUnitMeasureCode IN (N'M', N'DM', N'CM', N'MM', N'IN')
				OR SizeUnitMeasureCode IS NULL
			)
		)
		BEGIN
			-- If the unit of measure wasn't recognized raise an error and roll back
			-- the transaction
			RAISERROR ('Invalid Size Unit Measure Code.', 10, 127);
			ROLLBACK TRANSACTION;
		END
		ELSE
		BEGIN
			-- If the unit of measure is a recognized unit of measure then set the
			-- SizeUnitMeasureCode to centimeters and perform the Size conversion
			UPDATE Production.Product
			SET SizeUnitMeasureCode =
				CASE
					WHEN SizeUnitMeasureCode IS NULL THEN NULL
					ELSE N'CM'
					END,
				Size = CAST
					(
						CAST
							(
								CASE i.SizeUnitMeasureCode
									WHEN N'M' THEN CAST(i.Size AS float) * 100.0
									WHEN N'DM' THEN CAST(i.Size AS float) * 10.0
									WHEN N'CM' THEN CAST(i.Size AS float)
									WHEN N'MM' THEN CAST(i.Size AS float) * 0.10
									WHEN N'IN' THEN CAST(i.Size AS float) * 2.54
									END
								AS int
							) AS nvarchar(5)
					)
			FROM inserted i
			WHERE Production.Product.ProductID = i.ProductID
				AND i.SizeUnitMeasureCode IS NOT NULL;
		END;
	END;
END;
GO

