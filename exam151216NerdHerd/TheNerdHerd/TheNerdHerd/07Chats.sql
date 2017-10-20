SELECT
Title,
IsActive
FROM Chats
WHERE (IsActive=0 AND LEN(Title)<5) or SUBSTRING(Title,3,2)='tl'
ORDER BY Title DESC

--Select all chats that that are active and their title length is less than 5 or 3rd and 4th letters are equal to “tl”. 