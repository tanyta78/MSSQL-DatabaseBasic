--FIND USER GAME ID
DECLARE @userGameId INT=
(
    SELECT UG.Id
    FROM UsersGames UG
         JOIN Users U ON U.Id = UG.UserId
         JOIN Games G ON G.Id = UG.GameId
    WHERE U.Username = 'Alex'
          AND G.Name = 'Edinburgh'
);
-- INSERT WANTED ITEMS IN USER GAME ITEMS
INSERT INTO UserGameItems
(ItemId,
 UserGameId
)
       SELECT i.Id,
              @userGameId
       FROM Items AS i
       WHERE i.Name IN('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet');

-- PAY FOR ITEMS
UPDATE UsersGames
   SET Cash -= 
   (
	 SELECT SUM(i.Price)
	   FROM Items AS i
	  WHERE i.Name IN ('Blackguard', 'Bottomless Potion of Amplification', 
                  'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 
				  'Golden Gorget of Leoric', 'Hellfire Amulet')
   )
WHERE Id = @userGameId

--RETURN RESULT
SELECT u.Username
	   , g.Name
       , ug.Cash
	   , i.Name AS [Item Name]
  FROM Users AS u
  JOIN UsersGames AS ug ON u.Id = ug.UserId
  JOIN Games AS g ON ug.GameId = g.Id
  JOIN UserGameItems AS ugi ON ug.Id = ugi.UserGameId
  JOIN Items AS i ON ugi.ItemId = i.Id
 WHERE g.Name = 'Edinburgh'
ORDER BY i.Name