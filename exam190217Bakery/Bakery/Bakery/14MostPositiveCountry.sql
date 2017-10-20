SELECT CC.Name AS CountryName,AVG(Rate) AS AverageRate FROM Feedbacks AS F
JOIN Customers AS C ON F.CustomerId=C.Id
JOIN Countries AS CC ON CC.Id=C.CountryId
GROUP BY CC.Name
HAVING AVG(Rate)= (
		SELECT top(1) AVG(Rate) AS AverageRate 
		FROM Feedbacks AS F
		JOIN Customers AS C ON F.CustomerId=C.Id
		JOIN Countries AS CC ON CC.Id=C.CountryId
		GROUP BY CC.Name
		ORDER BY AverageRate DESC)
----
SELECT TOP (1) WITH TIES
    -- using WITH TIES is required by the JUDGE system
	   co.Name AS [CountryName]
	   , AVG(f.Rate) AS [FeedbackRate]
  FROM Customers AS c
  JOIN Countries AS co ON c.CountryId = co.Id
  JOIN Feedbacks AS f ON c.Id = f.CustomerId
 GROUP BY co.Name
ORDER BY AVG(f.Rate) DESC