
SELECT Username,
       g.Name,
       COUNT(ugi.ItemId) AS [ItemsCount],
       SUM(I.Price) AS [ItemsPrice]
FROM Games g
     JOIN UsersGames ug ON g.Id = ug.GameId
     JOIN Users u ON u.Id = ug.UserId
     JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
     JOIN Items i ON ugi.ItemId = i.Id
GROUP BY g.Name,
         Username
HAVING COUNT(ugi.ItemId) >= 10
ORDER BY ItemsCount desc, ItemsPrice desc, Username

