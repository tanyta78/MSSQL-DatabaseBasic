UPDATE Jobs
SET Status='In Progress',MechanicId=(
SELECT MechanicId FROM Mechanics
WHERE CONCAT(Mechanics.FirstName,' ',Mechanics.LastName)='Ryan Harnos')
WHERE Status='Pending'