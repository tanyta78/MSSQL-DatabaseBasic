
SELECT CONCAT(FirstName, ' ', LastName) AS Mechanic,
       COUNT(JobId) AS [Jobs]
FROM Mechanics
     JOIN Jobs ON Jobs.MechanicId = Mechanics.MechanicId
WHERE Status = 'In Progress'
GROUP BY Jobs.MechanicId,
         FirstName,
         LastName
HAVING COUNT(JobId) > 1
ORDER BY Jobs DESC,
         Jobs.MechanicId;