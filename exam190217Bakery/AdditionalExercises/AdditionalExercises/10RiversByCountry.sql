SELECT c.CountryName,
       cc.ContinentName,
       COUNT(cr.RiverId) AS [RiversCount],
       SUM(ISNULL(r.Length, 0)) AS [TotalLength]
FROM Countries c
     LEFT JOIN Continents cc ON c.ContinentCode = cc.ContinentCode
     LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
     LEFT JOIN Rivers r ON r.Id = cr.RiverId

GROUP BY C.CountryName,
         CC.ContinentName
ORDER BY COUNT(cr.RiverId) DESC,
         SUM(r.Length) DESC,
         c.CountryName;

SELECT c.CountryName AS [CountryName],
       cont.ContinentName AS [ContinentName],
       COUNT(cr.RiverId) AS [RiversCount],
       SUM(ISNULL(r.Length, 0)) AS [TotalLength]
FROM Countries AS c
     LEFT JOIN Continents AS cont ON c.ContinentCode = cont.ContinentCode
     LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
     LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY c.CountryName,
         cont.ContinentName
ORDER BY COUNT(cr.RiverId) DESC,
         SUM(r.Length) DESC,
         c.CountryName;