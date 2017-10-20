SELECT 
Manufacturers.Name,
SUM(Price) AS [Total Price]
FROM Lenses
JOIN Manufacturers ON Manufacturers.Id=Lenses.ManufacturerId
GROUP BY ManufacturerId,Manufacturers.Name
ORDER BY Name