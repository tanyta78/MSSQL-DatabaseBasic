--Problem 19.	*Scalar Function: Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames
(@gameName NVARCHAR(50)
)
RETURNS TABLE
AS
     RETURN
     WITH prices
          AS (
          SELECT Cash,
                 (ROW_NUMBER() OVER(ORDER BY ug.Cash DESC)) AS RowNum
          FROM UsersGames ug
               JOIN Games g ON ug.GameId = g.Id
          WHERE g.Name = @gameName)
          SELECT SUM(Cash) [SumCash]
          FROM prices
          WHERE RowNum % 2 = 1;

--Problem 20.	Trigger
--Problem 21.	*Massive Shopping

--Problem 22.	Number of Users for Email Provider

SELECT result.EmailProvider AS 'Email Provider',
       COUNT(result.EmailProvider) AS 'Number Of Users'
FROM
(
    SELECT SUBSTRING(u.Email, CHARINDEX('@', u.Email)+1, LEN(u.Email)) AS EmailProvider
    FROM Users AS u
    GROUP BY u.Email
) AS result
GROUP BY result.EmailProvider
ORDER BY 'Number Of Users' DESC,
         result.EmailProvider ASC;

--Problem 23.	All User in Games

SELECT g.Name AS [Game],
       gt.Name AS [Game Type],
       u.Username,
       level AS [Level],
       cash AS [Cash],
       ch.Name AS [Character]
FROM UsersGames AS ug
     JOIN Games AS g ON g.Id = ug.GameId
     JOIN GameTypes AS gt ON g.GameTypeId = gt.Id
     JOIN Users AS u ON u.Id = ug.UserId
     JOIN Characters AS ch ON ch.Id = ug.CharacterId
ORDER BY ug.Level DESC,
         u.Username,
         g.Name;

--Problem 24.	Users in Games with Their Items

SELECT u.Username,
       g.Name AS [Game],
       COUNT(ugi.UserGameId) AS [Items Count],
       SUM(i.Price) AS [Items Price]
FROM UsersGames AS ug
     JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
     JOIN Users AS u ON ug.UserId = u.Id
     JOIN Games AS g ON ug.GameId = g.Id
     JOIN Items AS i ON ugi.ItemId = i.Id
GROUP BY u.Username,
         g.Name
HAVING COUNT(ugi.ItemId) >= 10
ORDER BY [Items Count] DESC,
         [Items Price] DESC,
         u.Username;
SELECT u.Username,
       g.Name AS [Game],
       COUNT(ItemId) AS [Items Count],
       SUM(i.price) AS [Items Price]
FROM UserGameItems AS ugi
     JOIN UsersGames AS ug ON ugi.UserGameId = ug.Id
     JOIN Games AS g ON ug.GameId = g.Id
     JOIN Users AS u ON ug.UserId = u.Id
     JOIN Items AS i ON ugi.ItemId = i.Id
GROUP BY g.Name,
         u.Username
HAVING COUNT(ItemId) >= 10
ORDER BY [Items Count] DESC,
         [Items Price] DESC,
         u.Username;
SELECT u.Username,
       g.[Name] AS Game,
       COUNT(i.Id) AS 'Items Count',
       SUM(i.Price) AS 'Items Price'
FROM Games AS g
     INNER JOIN UsersGames AS ug ON ug.GameId = g.Id
     INNER JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
     INNER JOIN Items AS i ON i.Id = ugi.ItemId
     INNER JOIN Users AS u ON u.Id = ug.UserId
GROUP BY u.Username,
         g.[Name]
HAVING COUNT(i.Id) >= 10
ORDER BY COUNT(i.Id) DESC,
         SUM(i.Price) DESC,
         u.Username;

--Problem 25.	* User in Games with Their Statistics
--Problem 26.	All Items with Greater than Average Statistics

SELECT i.[Name],
       i.Price,
       i.MinLevel,
       itemsStats.Strength,
       itemsStats.Defence,
       itemsStats.Speed,
       itemsStats.Luck,
       itemsStats.Mind
FROM Items AS i
     INNER JOIN [Statistics] AS itemsStats ON itemsStats.Id = i.StatisticId
WHERE itemsStats.Mind >
(
    SELECT AVG(iStats.Mind) AS 'AverageMind'
    FROM Items AS i
         INNER JOIN [Statistics] AS iStats ON iStats.Defence = i.StatisticId
)
      AND itemsStats.Speed >
(
    SELECT AVG(iStats.Speed) AS 'AverageSpeed'
    FROM Items AS i
         INNER JOIN [Statistics] AS iStats ON iStats.Defence = i.StatisticId
)
          AND itemsStats.Luck >
(
    SELECT AVG(iStats.Luck) AS 'AverageLuck'
    FROM Items AS i
         INNER JOIN [Statistics] AS iStats ON iStats.Defence = i.StatisticId
)
    ORDER BY i.[Name];

--Problem 27.	Display All Items with Information about Forbidden Game Type

SELECT I.Name AS [Item],
       I.Price,
       I.MinLevel,
       GT.Name AS [Forbidden Game Type]
FROM Items AS I
     LEFT JOIN GameTypeForbiddenItems AS GTFI ON GTFI.ItemId = I.Id
     LEFT JOIN GameTypes AS GT ON GT.Id = GTFI.GameTypeId
ORDER BY GT.Name DESC,
         I.Name;


--Problem 28.	Buy Items for User in Game

SELECT Users.Id,
       Users.Username,
       UsersGames.GameId,
       UsersGames.Id AS UserGameId,
       Cash
INTO UserInfo
FROM Users
     INNER JOIN UsersGames ON UsersGames.UserId = Users.Id
     INNER JOIN Games ON Games.Id = UsersGames.GameId
WHERE Users.Username = 'Alex'
      AND Games.[Name] = 'Edinburgh';
SELECT Items.Id,
       Items.Price,
       Items.[Name]
INTO ItemsInfo
FROM Items
WHERE Items.[Name] IN('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet');
UPDATE UsersGames
  SET
      Cash-=
(
    SELECT SUM(Price)
    FROM ItemsInfo
)
WHERE UsersGames.Id =
(
    SELECT UserInfo.UserGameId
    FROM UserInfo
);
INSERT INTO UserGameItems
(UserGameId,
 ItemId
)
       SELECT
       (
           SELECT UserGameId
           FROM UserInfo
       ),
       Id
       FROM ItemsInfo;
DROP TABLE ItemsInfo;
DROP TABLE UserInfo;
SELECT Users.Username,
       Games.[Name],
       UsersGames.Cash,
       Items.[Name] AS 'Item Name'
FROM UsersGames
     INNER JOIN Games ON UsersGames.GameId = Games.Id
     INNER JOIN Users ON UsersGames.UserId = Users.Id
     INNER JOIN UserGameItems ON UserGameItems.UserGameId = UsersGames.Id
     INNER JOIN Items ON Items.Id = UserGameItems.ItemId
WHERE Games.[Name] = 'Edinburgh'
ORDER BY Items.[Name];









