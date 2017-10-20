SELECT 
Manufacturers.Name,
Cameras.Model,
Cameras.Price
FROM Cameras 
JOIN Manufacturers ON Manufacturers.Id=Cameras.ManufacturerId
WHERE Cameras.Price>(
			SELECT AVG(Price)
			FROM Cameras)
ORDER BY Cameras.Price DESC,Cameras.Model