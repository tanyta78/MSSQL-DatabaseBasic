SELECT Users.Id, Users.Username, UsersGames.GameId, UsersGames.Id AS UserGameId, Cash
INTO UserInfo
FROM Users
INNER JOIN UsersGames
  ON UsersGames.UserId = Users.Id
INNER JOIN Games
  ON Games.Id = UsersGames.GameId
WHERE Users.Username = 'Alex' AND Games.[Name] = 'Edinburgh'


SELECT Items.Id, Items.Price, Items.[Name]
INTO ItemsInfo
FROM Items
WHERE Items.[Name] IN ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')

UPDATE UsersGames
SET Cash -= (SELECT SUM(Price) FROM ItemsInfo)
WHERE UsersGames.Id = (SELECT UserInfo.UserGameId  FROM UserInfo)

INSERT INTO UserGameItems(UserGameId, ItemId)
SELECT (SELECT UserGameId FROM UserInfo), Id FROM ItemsInfo

DROP TABLE ItemsInfo
DROP TABLE UserInfo

SELECT Users.Username,
       Games.[Name], 
	   UsersGames.Cash,
	   Items.[Name] AS 'Item Name'
FROM UsersGames
INNER JOIN Games
  ON UsersGames.GameId = Games.Id 
INNER JOIN Users
  ON UsersGames.UserId = Users.Id 
INNER JOIN UserGameItems
  ON UserGameItems.UserGameId = UsersGames.Id
INNER JOIN Items
  ON Items.Id = UserGameItems.ItemId
WHERE Games.[Name] = 'Edinburgh'
ORDER BY Items.[Name]