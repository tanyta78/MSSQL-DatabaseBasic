

SELECT TOP(1) WITH TIES C.Title,M.Content
FROM Messages AS M
RIGHT JOIN Chats AS C ON M.ChatId=C.Id
ORDER BY C.StartDate DESC

SELECT TOP(1) C.Title,M.Content
FROM Messages AS M
RIGHT JOIN Chats AS C ON M.ChatId=C.Id
ORDER BY C.StartDate DESC