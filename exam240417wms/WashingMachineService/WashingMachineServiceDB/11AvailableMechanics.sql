

SELECT CONCAT(FirstName, ' ', LastName) AS Available
FROM Mechanics
WHERE Mechanics.MechanicId NOT IN
(
    SELECT DISTINCT
           Mechanics.MechanicId
    FROM Mechanics
         LEFT JOIN Jobs ON Jobs.MechanicId = Mechanics.MechanicId
    WHERE Status <> 'Finished'
)
ORDER BY Mechanics.MechanicId;
