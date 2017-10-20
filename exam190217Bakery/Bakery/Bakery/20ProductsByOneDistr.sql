SELECT (
		SELECT p.Name 
		  FROM Products AS p 
		 WHERE p.Id = ip.ProductId
	   ) AS ProductName

	   , (
		  SELECT AVG(f.Rate) 
		    FROM Feedbacks AS f 
		   WHERE f.ProductId = ip.ProductId 
		   GROUP BY f.ProductId
		 ) AS ProductAverageRate

       , (
	      SELECT TOP (1) 
		         d.Name 
		    FROM Distributors AS d
			JOIN Ingredients AS i ON i.DistributorId = d.Id
			JOIN ProductsIngredients AS ip2 ON i.Id = ip2.IngredientId 
			WHERE ip2.ProductId = ip.ProductId
	     ) AS DistributorName
		 
		, (
		   SELECT c.Name 
		     FROM Countries AS c 
			WHERE c.Id = (
						   SELECT TOP (1) 
						          d.CountryId 
						     FROM Distributors AS d
						     JOIN Ingredients AS i ON i.DistributorId = d.Id
						     JOIN ProductsIngredients AS ip2 ON i.Id = ip2.IngredientId 
						    WHERE ip2.ProductId = ip.ProductId
						 )
		  ) AS DistributorCountry 
  FROM Products AS p
  JOIN ProductsIngredients AS ip ON p.Id = ip.ProductId
  JOIN Ingredients AS i ON ip.IngredientId = i.Id
 GROUP BY ip.ProductId
HAVING COUNT(DISTINCT i.DistributorId) = 1
ORDER BY ip.ProductId