DELETE FROM Locations
WHERE Locations.Id IN(SELECT Locations.Id AS LocationId
FROM Locations
LEFT JOIN Users ON Locations.Id=Users.LocationId
GROUP BY Locations.Id
HAVING COUNT(Users.Id)=0)


--OTHER SOLUTION
DELETE FROM Locations
WHERE Id NOT IN (SELECT DISTINCT LocationId FROM Users WHERE LocationId IS NOT NULL)