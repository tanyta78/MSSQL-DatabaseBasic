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
SELECT L.LeagueName AS [League Name],
       COUNT(DISTINCT TeamId) AS [Teams],
	  COUNT(DISTINCT MatchDate) AS [Matches],
	   ISNULL(AVG(TM.HomeGoals + TM.AwayGoals), 0) [Average Goals]
FROM Leagues_Teams LT
     JOIN Leagues L ON L.Id = LT.LeagueId
     JOIN Teams T ON T.Id = LT.TeamId
	LEFT JOIN TeamMatches TM ON TM.LeagueId=l.Id
GROUP BY L.LeagueName
ORDER BY Teams DESC,Matches DESC

--Problem 9.	Total Goals per Team in all Matches

SELECT t.TeamName AS [TeamName],
       ISNULL(SUM(TMH.HomeGoals), 0) + ISNULL(SUM(TMA.AwayGoals), 0) AS [Total Goals]
FROM Teams T
     LEFT JOIN TeamMatches TMH ON TMH.HomeTeamId = T.Id
     LEFT JOIN TeamMatches TMA ON TMA.AwayTeamId = T.Id
GROUP BY T.TeamName
ORDER BY [Total Goals] DESC, [TeamName]

--Problem 10.	Pairs of Matches on the Same Day

SELECT TM1.MatchDate AS [First Date],
       TM2.MatchDate AS [Second Date]
FROM TeamMatches TM1
     JOIN TeamMatches TM2 ON TM2.Id != TM1.Id
WHERE DAY(TM1.MatchDate) = DAY(TM2.MatchDate)
      AND TM2.MatchDate > TM1.MatchDate
ORDER BY TM1.MatchDate DESC,
         TM2.MatchDate DESC;

--Problem 11.	Mix of Team Names
SELECT CONCAT(LEFT(T1.TeamName, LEN(T1.TeamName) - 1), REVERSE(T2.TeamName)) AS MIX
FROM Teams T1
     CROSS JOIN Teams T2
WHERE RIGHT(T1.TeamName, 1) = LEFT(REVERSE(T2.TeamName), 1)
ORDER BY [Mix];
--Problem 11.	Mix of Team Names
SELECT LOWER(SUBSTRING(t1.teamname, 1, LEN(t1.TeamName) - 1) +  REVERSE(t2.TeamName)) AS [Mix]
  FROM Teams t1, Teams t2
 WHERE RIGHT(t1.TeamName, 1) = RIGHT(t2.TeamName, 1)
ORDER BY [Mix]

--Problem 12.	Countries with International and Team Matches
SELECT c.CountryName AS [Country Name],
       COUNT(DISTINCT IM.Id) AS [International Matches],
       COUNT(DISTINCT TM.Id) AS [Team Matches]
FROM Countries C
     LEFT JOIN InternationalMatches IM ON IM.HomeCountryCode = C.CountryCode
     LEFT JOIN Leagues L ON L.CountryCode = C.CountryCode
     LEFT JOIN TeamMatches TM ON TM.LeagueId = L.Id
GROUP BY C.CountryName
HAVING  COUNT(DISTINCT IM.Id)>0 OR COUNT(DISTINCT TM.Id)>0
ORDER BY COUNT(IM.Id) DESC, COUNT(TM.Id) DESC, C.CountryName

--