SELECT u.Username,
       g.Name as [Game],
	  MAX(c.Name)as [Character],
	  SUM(SI.Strength) + MAX(bsi.Strength) + MAX(csi.Strength) as [Strength],
	  SUM(SI.Defence) + MAX(csi.Defence) + MAX(bsi.Defence) as [Defence],
	  SUM(SI.Speed) + MAX(bsi.Speed) + MAX(csi.Speed) as [Speed],
       SUM(SI.Mind) + MAX(bsi.Mind) + MAX(csi.Mind) as [Mind],
       SUM(SI.Luck) + MAX(bsi.Luck) + MAX(csi.Luck) as [Luck]
FROM UsersGames ug
     JOIN Games g ON g.Id = ug.GameId
     JOIN GameTypes gt ON gt.Id = g.GameTypeId
     JOIN [Statistics] bsi ON gt.BonusStatsId = bsi.Id
     JOIN Characters c ON c.Id = ug.CharacterId
     JOIN [Statistics] csi ON c.StatisticId=csi.Id
     JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
     JOIN Items i ON ugi.ItemId = i.Id
     JOIN [Statistics] si ON i.StatisticId = si.Id
	JOIN Users U ON ug.UserId=u.Id
GROUP BY u.Username,g.Name
order by Strength desc,Defence desc,Speed desc,Mind desc,Luck desc

SELECT u.Username AS [Username]
	   , g.Name AS [Game]
	   , MAX(c.Name) AS [Character]
	   , SUM(its.strength) + MAX(gts.strength) + MAX(cs.strength) AS [Strength]
	   , SUM(its.defence) + MAX(gts.defence) + MAX(cs.defence) AS [Defence]
	   , SUM(its.speed) + MAX(gts.speed) + MAX(cs.speed) AS [Speed]
	   , SUM(its.mind) + MAX(gts.mind) + MAX(cs.mind) AS [Mind]
	   , SUM(its.luck) + MAX(gts.luck) + MAX(cs.luck) AS [Luck]
  FROM Users AS u
  JOIN UsersGames AS ug ON u.Id = ug.UserId
  JOIN Games AS g ON ug.GameId = g.Id

  JOIN GameTypes AS gt ON g.GameTypeId = gt.Id
  JOIN [Statistics] AS gts ON gt.BonusStatsId = gts.Id

  JOIN UserGameItems AS ugi ON ug.Id = ugi.UserGameId
  JOIN Items AS i ON ugi.ItemId = i.Id
  JOIN [Statistics] AS its ON i.StatisticId = its.Id

  JOIN Characters AS c ON ug.CharacterId = c.Id
  JOIN [Statistics] AS cs ON c.StatisticId = cs.Id
 GROUP BY u.Username, g.Name
ORDER BY Strength DESC, Defence DESC, Speed DESC, Mind DESC, Luck DESC