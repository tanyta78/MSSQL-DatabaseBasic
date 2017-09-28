SELECT 
CONCAT(FirstName,' ',LastName) AS Mechanic,
AVG(DATEDIFF(DAY,IssueDate,FinishDate)) AS [Average days]
FROM Mechanics
JOIN Jobs ON Jobs.MechanicId=Mechanics.MechanicId
WHERE Status='Finished'
GROUP BY Jobs.MechanicId,FirstName,LastName
