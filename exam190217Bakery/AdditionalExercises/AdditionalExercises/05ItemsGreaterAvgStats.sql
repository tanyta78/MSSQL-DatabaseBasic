SELECT 
i.Name,
i.Price,
i.MinLevel,
s.Strength,
s.Defence,
s.Speed,
s.Luck,
s.Mind
FROM Items i
     JOIN [Statistics] s ON i.StatisticId = s.Id
WHERE s.Mind > (SELECT AVG(Mind) FROM [Statistics]) 
   AND s.Speed > (SELECT AVG(Speed) FROM [Statistics]) 
   AND s.Luck > (SELECT AVG(Luck) FROM [Statistics]) 
ORDER BY i.Name