SELECT
CONCAT(Mechanics.FirstName,' ',Mechanics.LastName) AS Mechanic,
Vendors.Name as Vendor,
SUM(OrderParts.Quantity) AS Parts,
RANK() OVER (PARTITION BY CONCAT(Mechanics.FirstName,' ',Mechanics.LastName) ORDER BY SUM(OrderParts.Quantity)) as PreferenceRank
from Mechanics
JOIN Jobs ON Jobs.MechanicId=Mechanics.MechanicId
JOIN Orders ON Orders.JobId=Jobs.JobId
JOIN OrderParts ON OrderParts.OrderId=Orders.OrderId
JOIN Parts ON OrderParts.PartId=Parts.PartId
JOIN Vendors ON Parts.VendorId=Vendors.VendorId 
GROUP BY CONCAT(Mechanics.FirstName,' ',Mechanics.LastName),Vendors.Name
ORDER BY Mechanic,Parts desc,Vendor