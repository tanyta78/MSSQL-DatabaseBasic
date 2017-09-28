SELECT 
CONCAT(FirstName,' ',LastName) AS Available
FROM Mechanics
left JOIN Jobs ON Jobs.MechanicId=Mechanics.MechanicId
WHERE Mechanics.MechanicId not in(
SELECT 
Mechanics.MechanicId
FROM Mechanics
left JOIN Jobs ON Jobs.MechanicId=Mechanics.MechanicId
WHERE Status<>'Finished' 
GROUP BY Mechanics.MechanicId)
group by Mechanics.MechanicId,FirstName,LastName
order by Mechanics.MechanicId
