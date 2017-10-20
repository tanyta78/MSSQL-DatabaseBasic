SELECT Name FROM Manufacturers
LEFT JOIN Cameras ON Cameras.ManufacturerId=Manufacturers.Id
LEFT JOIN Lenses ON Lenses.ManufacturerId=Manufacturers.Id
WHERE Cameras.Id IS NULL AND Lenses.Id IS NULL
ORDER BY Name