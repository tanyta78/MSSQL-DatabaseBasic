UPDATE [Chats]
   SET StartDate = ( 
			        SELECT MIN(m.SentOn) 
					  FROM [Chats] AS c 
					  JOIN [Messages] AS m ON c.Id = m.ChatId 
					 WHERE c.Id = Chats.Id 
				   )
 WHERE Chats.Id IN (
					SELECT c.Id 
					  FROM Chats AS c 
					  JOIN [Messages] AS m ON c.Id = m.ChatId 
					 GROUP BY c.Id, c.StartDate 
					HAVING c.StartDate > MIN(m.SentOn)
)
--FOR CHECK
SELECT COUNT(*) 
FROM Chats AS c
INNER JOIN Messages AS m
ON c.Id = m.ChatId
WHERE c.StartDate > m.SentOn
