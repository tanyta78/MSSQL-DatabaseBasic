WITH RankingCTE AS(SELECT 
P.Title,
C.Name AS [Category Name],
CAM.Model,
M.Name AS [Manufacturer Name],
CAM.Megapixels,
CAM.Price,
RANK() over (PARTITION BY C.Name ORDER BY CAM.Price DESC) AS R
FROM Photographs AS P
JOIN Categories AS C ON P.CategoryId=C.Id
JOIN Equipments AS E ON E.Id=P.EquipmentId
JOIN Cameras AS CAM ON CAM.Id=E.CameraId
JOIN Manufacturers AS M ON M.Id=CAM.ManufacturerId)

SELECT 
Title,
[Category Name],
Model,
[Manufacturer Name],
Megapixels,
Price FROM RankingCTE
WHERE R=1
ORDER BY Price DESC,Title

----
SELECT p.Title AS [Title]
       , cat.Name AS [Category Name]
	   , c.Model AS [Model]
	   , m.Name AS [Manufacturer Name]
	   , c.Megapixels AS [Megapixels]
       , c.Price AS [Price]
  FROM Photographs AS p
  JOIN Categories AS cat ON p.CategoryId = cat.Id
  JOIN Equipments AS e ON p.EquipmentId = e.Id
  JOIN Cameras AS c ON e.CameraId = c.Id
  JOIN Manufacturers m ON c.ManufacturerId = m.Id
 WHERE c.Price = (
				  SELECT MAX(cam.Price)
				    FROM Cameras AS cam
				    JOIN Equipments AS equip ON cam.Id = equip.CameraId
				    JOIN Photographs AS photo ON equip.Id = photo.EquipmentId
				   WHERE photo.CategoryId = p.CategoryId
				 )
 ORDER BY [Price] DESC, [Title]
