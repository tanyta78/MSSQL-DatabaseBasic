--Problem 33.	Population and Area by Continent

SELECT CC.ContinentName,
       SUM(CAST(ISNULL(c.AreaInSqKm, 0) AS BIGINT)) AS CountriesArea,
       SUM(CAST(ISNULL(c.[Population], 0) AS BIGINT)) AS CountriesPopulation
FROM Continents AS CC
     JOIN Countries AS C ON C.ContinentCode = CC.ContinentCode
GROUP BY CC.ContinentName
ORDER BY CountriesPopulation DESC;

--
INSERT INTO [Messages](Content, SentOn, ChatId, UserId)
     SELECT  CONCAT(u.Age, '-', u.Gender, '-', l.Latitude, '-', l.Longitude)
			 , CONVERT(DATE, GETDATE()) 
			 , CASE u.Gender 
					WHEN 'F' THEN CEILING(SQRT(u.Age * 2))
					WHEN 'M' THEN CEILING(POWER(u.Age / 18, 3))
			   END
			 , u.Id
   	   FROM Users AS u
	   JOIN Locations AS l ON u.LocationId = l.Id
WHERE u.Id BETWEEN 10 AND 20