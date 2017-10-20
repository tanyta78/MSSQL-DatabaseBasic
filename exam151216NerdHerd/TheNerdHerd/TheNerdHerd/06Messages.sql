SELECT
Content,
SentOn
FROM Messages
WHERE SentOn>'2014-05-12' AND CHARINDEX('JUST',Content)>0
ORDER BY Messages.Id DESC