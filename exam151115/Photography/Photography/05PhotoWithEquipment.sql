SELECT 
Title,
Cameras.Model AS [CameraModel],
Lenses.Model AS [LensModel]
FROM Photographs
JOIN Equipments ON Equipments.Id=Photographs.EquipmentId
JOIN Cameras ON Cameras.Id=Equipments.CameraId
JOIN Lenses ON Lenses.Id=Equipments.LensId
ORDER BY Title