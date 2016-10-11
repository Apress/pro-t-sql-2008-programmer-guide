USE AdventureWorks;
GO

CREATE PROCEDURE dbo.GetEmployee 
(
	@BusinessEntityID int = 199,
	@Email_Address nvarchar(50) OUTPUT,
	@Full_Name nvarchar(100) OUTPUT
)
AS
BEGIN
	-- Retrieve email address and full name from HumanResources.Employee table
	SELECT 
		@Email_Address = ea.EmailAddress,
		@Full_Name = p.FirstName + ' ' + COALESCE(p.MiddleName,'') + ' ' + p.LastName
	FROM HumanResources.Employee e
	INNER JOIN Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	INNER JOIN Person.EmailAddress ea
		ON p.BusinessEntityID = ea.BusinessEntityID
	WHERE e.BusinessEntityID = @BusinessEntityID;

	-- Return a code of 1 when no match is found, 0 for success
	RETURN 
	(
		CASE
			WHEN @Email_Address IS NULL THEN 1
			ELSE 0
			END
	);
END;
GO
