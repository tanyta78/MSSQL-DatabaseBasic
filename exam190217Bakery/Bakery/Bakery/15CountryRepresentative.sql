SELECT 
		res.CountryName AS [CountryName],
		res.DistributorName AS [DisributorName]
FROM (
		SELECT	d.Name AS [DistributorName],
				c.Name AS [CountryName],
				DENSE_RANK() OVER (PARTITION BY c.Name ORDER BY COUNT(i.Id) DESC) AS [curRank]
          FROM Countries AS c
          LEFT JOIN Distributors AS d ON c.Id = d.CountryId
	      LEFT JOIN Ingredients AS i ON d.Id = i.DistributorId
         GROUP BY d.Name, c.Name
		) AS res
WHERE res.curRank = 1
		AND res.DistributorName IS NOT NULL