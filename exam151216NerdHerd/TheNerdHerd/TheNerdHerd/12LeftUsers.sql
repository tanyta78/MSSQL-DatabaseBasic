SELECT 
Messages.Id,
Messages.ChatId,
Messages.UserId
FROM Messages
WHERE ChatId=17
AND UserId NOT IN(SELECT UserId
				FROM UsersChats
				WHERE ChatId=17)
OR Messages.UserId IS NULL
ORDER BY Messages.Id DESC

-- what is the difference

SELECT 
Id,
ChatId,
UserId
FROM Messages
WHERE ChatId=17
AND UserId NOT IN(SELECT UserId
				FROM UsersChats
				WHERE ChatId=17)
OR UserId IS NULL
ORDER BY Id DESC
