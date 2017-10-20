--1.	Create a table FriendlyMatches(Id, HomeTeamID, AwayTeamId, MatchDate). 
CREATE TABLE FriendlyMatches
(
 Id         INT IDENTITY PRIMARY KEY,
 HomeTeamId INT FOREIGN KEY REFERENCES Teams(Id),
 AwayTeamId INT FOREIGN KEY REFERENCES Teams(Id),
 MatchDate  DATETIME
);
--2.	Execute the following SQL script 
INSERT INTO Teams(TeamName) VALUES
 ('US All Stars'),
 ('Formula 1 Drivers'),
 ('Actors'),
 ('FIFA Legends'),
 ('UEFA Legends'),
 ('Svetlio & The Legends')
GO

INSERT INTO FriendlyMatches(
  HomeTeamId, AwayTeamId, MatchDate) VALUES
  
((SELECT Id FROM Teams WHERE TeamName='US All Stars'), 
 (SELECT Id FROM Teams WHERE TeamName='Liverpool'),
 '30-Jun-2015 17:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Formula 1 Drivers'), 
 (SELECT Id FROM Teams WHERE TeamName='Porto'),
 '12-May-2015 10:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Actors'), 
 (SELECT Id FROM Teams WHERE TeamName='Manchester United'),
 '30-Jan-2015 17:00'),

((SELECT Id FROM Teams WHERE TeamName='FIFA Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='UEFA Legends'),
 '23-Dec-2015 18:00'),

((SELECT Id FROM Teams WHERE TeamName='Svetlio & The Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='Ludogorets'),
 '22-Jun-2015 21:00')

GO
--3.	Write a query to display all non-international matches along with the given team names, starting from the newest date and ending with games with no date. 
SELECT TH.TeamName AS [Home Team],
       TA.TeamName AS [Away Team],
       f.MatchDate AS [Match Date]
FROM FriendlyMatches F
     JOIN Teams TH ON TH.Id = F.HomeTeamId
     JOIN Teams TA ON TA.Id = F.AwayTeamId
UNION
SELECT TH.TeamName AS [Home Team],
       TA.TeamName AS [Away Team],
       TM.MatchDate AS [Match Date]
FROM TeamMatches TM
     JOIN Teams TH ON TH.Id = TM.HomeTeamId
     JOIN Teams TA ON TA.Id = TM.AwayTeamId
ORDER BY [Match Date] DESC


--Problem 14.	Seasonal Matches