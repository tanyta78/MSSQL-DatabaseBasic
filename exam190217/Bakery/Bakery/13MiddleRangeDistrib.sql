WITH RatedProducts as(SELECT F.ProductId as ProductId,AVG(Rate) as AverageRate
					FROM Feedbacks AS F
					GROUP BY F.ProductId
					HAVING AVG(Rate) BETWEEN 5 AND 8)

SELECT D.Name AS DistributorName,I.Name AS IngrediantName,P.Name,RatedProducts.AverageRate
FROM ProductsIngredients AS [PI]
JOIN Ingredients AS I ON I.Id=[PI].IngredientId
right join Products as P ON P.Id=PI.ProductId
join RatedProducts on RatedProducts.ProductId=[PI].ProductId 
JOIN Distributors AS D ON D.Id=I.DistributorId
ORDER BY d.Name,i.Name,p.Name