
SELECT con.ContinentName,
       SUM(CONVERT(BIGINT, c.AreaInSqKm)) AS [CountriesArea],
       SUM(CONVERT(BIGINT, c.Population)) AS [CountriesPopulation]
FROM Continents con
     RIGHT JOIN Countries c ON c.ContinentCode = con.ContinentCode
GROUP BY con.ContinentName
order by CountriesPopulation desc