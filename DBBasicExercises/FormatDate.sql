SELECT TOP(50)
[Name],FORMAT([Start],'yyyy-MM-dd') AS [Start]
FROM [Games] as g
WHERE YEAR(g.[Start]) BETWEEN 2011 AND 2012
ORDER BY g.[Start],[Name]


SELECT 
	Name AS Game,
	CASE WHEN DATEPART(HOUR,Start) BETWEEN 0 AND 11 THEN 'Morning' 
		 WHEN DATEPART(HOUR,Start) BETWEEN 12 AND 17 THEN 'Afternoon' 
	     WHEN DATEPART(HOUR,Start) BETWEEN 18 AND 24 THEN 'Evening' 
	END AS [Part of the Day],
	CASE WHEN Duration <=3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration >6 THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
FROM Games
ORDER BY Game,[Duration],[Part of the Day]