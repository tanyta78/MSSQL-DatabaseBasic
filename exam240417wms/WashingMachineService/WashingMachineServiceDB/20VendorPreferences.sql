WITH CTE_VendorPreference
AS
(
		  SELECT	M.MechanicId,
				V.VendorId,
				SUM(OP.Quantity) AS VendorsItems
		  FROM Mechanics as M 
			 JOIN Jobs J ON J.MechanicId=M.MechanicId
			 JOIN Orders O ON O.JobId=J.JobId
			 JOIN OrderParts OP ON OP.OrderId=O.OrderId
			 JOIN Parts AS P ON P.PartId=OP.PartId
			 JOIN Vendors AS V ON V.VendorId=P.VendorId
		  GROUP BY M.MechanicId,V.VendorId
)

SELECT  M.FirstName+' '+M.LastName AS Mechanic,
	   v.Name as Vendor,
	   C.VendorsItems AS Parts,
	   CAST(CAST(CAST(VendorsItems as DECIMAL(6,2))/(SELECT SUM(VendorsItems)FROM CTE_VendorPreference WHERE MechanicId=C.MechanicId)*100 AS INT)AS VARCHAR(20))+'%' AS Preference
FROM CTE_VendorPreference AS C
JOIN Mechanics M ON M.MechanicId=C.MechanicId
JOIN Vendors V ON V.VendorId=C.VendorId
ORDER BY Mechanic,Parts DESC,Vendor