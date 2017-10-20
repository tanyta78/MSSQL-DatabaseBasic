SELECT p.PeakName,
       m.MountainRange,
       c.CountryName,
       cc.ContinentName
FROM Peaks p
     JOIN Mountains m ON p.MountainId = m.Id
     JOIN MountainsCountries mc ON mc.MountainId = m.Id
     JOIN Countries c ON c.CountryCode = mc.CountryCode
     JOIN Continents cc ON cc.ContinentCode = c.ContinentCode
ORDER BY PeakName;