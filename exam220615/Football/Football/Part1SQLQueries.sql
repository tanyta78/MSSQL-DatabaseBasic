--Problem 1.	All Teams
SELECT TeamName FROM Teams

--Problem 2.	Biggest Countries by Population
SELECT TOP(50)
CountryName,
Population
FROM Countries
ORDER BY Population DESC;

--Problem 3.	Countries and Currency (Eurzone)
SELECT 
CountryName,
CountryCode,
CASE WHEN CurrencyCode='EUR' THEN 'Inside' ELSE 'Outside' end as Eurozone
FROM Countries
ORDER BY CountryName

--Problem 4.	Teams Holding Numbers
SELECT TeamName,
       CountryCode
FROM Teams
WHERE TeamName LIKE '%[0-9]%';

--Problem 5.	International Matches
SELECT CH.CountryName AS [Home Team],
       CA.CountryName AS [Away Team],
       MatchDate AS [Match Date]
FROM InternationalMatches IM
     JOIN Countries CH ON CH.CountryCode = IM.HomeCountryCode
     JOIN Countries CA ON CA.CountryCode = IM.AwayCountryCode
ORDER BY MatchDate DESC;

--Problem 6.	*Teams with their League and League Country
SELECT TeamName AS [Team Name],
       LeagueName AS [League],
       ISNULL(C.CountryName, 'International') AS [League Country]
FROM Teams T
     JOIN Leagues_Teams LT ON LT.TeamId = T.Id
     JOIN Leagues L ON L.Id = LT.LeagueId
     LEFT JOIN Countries C ON C.CountryCode = L.CountryCode
ORDER BY TeamName;

--Problem 7.	* Teams with more than One Match

SELECT T.TeamName AS [Team],
       COUNT(T.Id) AS [Matches Count]
FROM TeamMatches TM
     JOIN Teams T ON T.Id = TM.AwayTeamId
                     OR T.Id = TM.HomeTeamId
GROUP BY T.TeamName
HAVING COUNT(T.Id) > 1
ORDER BY T.TeamName;

--Problem 8.	Number of Teams and Matches in Leagues