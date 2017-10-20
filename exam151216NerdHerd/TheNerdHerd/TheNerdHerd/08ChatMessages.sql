SELECT 
Chats.Id,
Title,
Messages.Id
FROM Chats
JOIN Messages ON Chats.Id=Messages.ChatId
WHERE Messages.SentOn<'2012-03-26' AND Title LIKE '%X'
ORDER BY Chats.Id,Messages.Id