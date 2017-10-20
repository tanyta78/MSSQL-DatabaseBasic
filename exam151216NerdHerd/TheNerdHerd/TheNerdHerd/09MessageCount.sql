SELECT TOP (5) 
	   m.ChatId,
	   COUNT(m.Id) AS TotalMessages 
  FROM [Messages] AS m
 WHERE m.Id < 90
 GROUP BY m.ChatId
ORDER BY COUNT(m.Id) DESC, m.ChatId