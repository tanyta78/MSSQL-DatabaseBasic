WITH CTE_SingleDistrProduct as (SELECT  P.Id
FROM Products P
JOIN ProductsIngredients PRI ON PRI.ProductId=P.Id
JOIN Ingredients I ON I.Id=PRI.IngredientId
JOIN Distributors D ON D.Id=I.DistributorId
GROUP BY P.Id
HAVING COUNT(DISTINCT D.Id)=1
)

SELECT 
 p.Name AS ProductName, AVG(f.Rate) AS ProductAverageRate,
d.Name AS DistributorName, c.Name AS DistributorCountry
FROM CTE_SingleDistrProduct
JOIN Products P ON P.Id=CTE_SingleDistrProduct.Id
JOIN ProductsIngredients PRI ON PRI.ProductId=P.Id
JOIN Ingredients I ON I.Id=PRI.IngredientId
JOIN Distributors D ON D.Id=I.DistributorId
JOIN Countries C ON C.Id=D.CountryId
JOIN Feedbacks F ON F.ProductId=P.Id
GROUP BY P.Id,P.Name,D.Name,C.Name
ORDER BY P.Id
