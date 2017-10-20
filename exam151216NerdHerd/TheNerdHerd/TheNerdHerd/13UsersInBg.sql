SELECT 
Users.Nickname,
Chats.Title,
Locations.Latitude,
Locations.Longitude
FROM Users
JOIN UsersChats ON Users.Id=UsersChats.UserId
right JOIN Chats ON UsersChats.ChatId=Chats.Id
JOIN Locations ON Locations.Id=Users.LocationId
WHERE (CAST(Latitude AS numeric(38,18)) BETWEEN 41.14 AND 44.13)
		AND (CAST(Longitude AS numeric(38,18)) BETWEEN 22.21 AND 28.36)
ORDER BY Chats.Title