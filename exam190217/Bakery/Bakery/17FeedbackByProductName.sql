CREATE FUNCTION udf_GetRating(@Name NVARCHAR(25))
RETURNS VARCHAR(10)
BEGIN
	DECLARE @Rating NVARCHAR(10)
	DECLARE @ProductRate DECIMAL(10,2)

	SET @ProductRate = (
						 SELECT AVG(f.Rate) 
						   FROM Products AS p
						   JOIN Feedbacks AS f ON p.Id = f.ProductId
						  GROUP BY f.ProductId,P.Name
						  HAVING p.Name = @Name
					   )
	IF @ProductRate < 5
	BEGIN
	   SET @Rating = 'Bad'
	END
	ELSE IF @ProductRate BETWEEN 5 AND 8
	BEGIN
	   SET @Rating = 'Average'
	END
	ElSE IF @ProductRate > 8
	BEGIN
	   SET @Rating = 'Good'
	END
	ELSE 
	BEGIN
	   SET @Rating = 'No rating'
	END

	RETURN @Rating
END 

