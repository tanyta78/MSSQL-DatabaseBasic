
BEGIN TRANSACTION

DECLARE @userGameId INT = (SELECT UG.Id as Level FROM UsersGames UG
JOIN Users U ON U.Id=UG.UserId
JOIN Games G ON G.Id=UG.GameId
WHERE U.Username='Stamat' and G.Name='Safflower')


DECLARE @userGameLevel INT = (SELECT UG.Level as Level FROM UsersGames UG
JOIN Users U ON U.Id=UG.UserId
JOIN Games G ON G.Id=UG.GameId
WHERE U.Username='Stamat' and G.Name='Safflower')

DECLARE @userGameCash DECIMAL = (SELECT UG.Cash as cash FROM UsersGames UG
JOIN Users U ON U.Id=UG.UserId
JOIN Games G ON G.Id=UG.GameId
WHERE U.Username='Stamat' and G.Name='Safflower')

DECLARE @Sum DECIMAL = (SELECT SUM(i.Price)
					      FROM Items AS i
				    WHERE (MinLevel BETWEEN 11 AND 12) OR (MinLevel BETWEEN 19 AND 21))

IF @userGameCash < @Sum
BEGIN
   ROLLBACK
END
ELSE 
BEGIN
UPDATE UsersGames
	   SET Cash -= @Sum
	 WHERE Id = @userGameId

INSERT INTO UserGameItems (UserGameId, ItemId)
	 SELECT @userGameId, Id 
	   FROM Items 
	  WHERE (MinLevel BETWEEN 11 AND 12) OR(MinLevel BETWEEN 19 AND 21)
	 COMMIT
END

SELECT i.Name AS [Item Name] 
  FROM UserGameItems ugi
  JOIN Items i ON ugi.ItemId = i.Id
WHERE ugi.UserGameId = @userGameId
ORDER BY [Item Name]