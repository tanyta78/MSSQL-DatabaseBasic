SELECT 
PeakName,
MountainRange AS [Mountain],
Elevation
FROM Peaks p
     JOIN Mountains m ON p.MountainId = m.Id
ORDER BY P.Elevation DESC,P.PeakName