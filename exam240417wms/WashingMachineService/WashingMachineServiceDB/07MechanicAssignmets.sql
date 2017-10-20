SELECT 
CONCAT(FirstName,' ',LastName) AS Mechanic,
Status,
IssueDate
FROM Mechanics
JOIN Jobs ON Jobs.MechanicId=Mechanics.MechanicId
ORDER BY Jobs.MechanicId,Jobs.IssueDate,Jobs.JobId