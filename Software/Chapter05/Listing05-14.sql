USE AdventureWorks;
GO

SELECT
	Num,
	Element
FROM dbo.GetCommaSplit ('Michael,Tito,Jermaine,Marlon,Rebbie,Jackie,Janet,La Toya,Randy');
GO
