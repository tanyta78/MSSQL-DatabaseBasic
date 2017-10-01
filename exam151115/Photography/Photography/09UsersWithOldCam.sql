SELECT 
Users.FullName,
Manufacturers.Name AS [Manufacturer],
Cameras.Model AS [Camera Model],
Cameras.Megapixels
FROM Users
JOIN Equipments ON Users.EquipmentId=Equipments.Id
JOIN Cameras ON Cameras.Id=Equipments.CameraId
JOIN Manufacturers ON Cameras.ManufacturerId=Manufacturers.Id
WHERE Cameras.Year<2015
ORDER BY FullName