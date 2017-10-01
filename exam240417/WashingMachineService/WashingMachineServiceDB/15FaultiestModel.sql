

WITH FaultiestCTE (ModelsID, NumberOfFaults)  
AS  
(  
    SELECT Models.ModelId,
			COUNT(JobId)
			FROM Models
			JOIN Jobs ON Models.ModelId=Jobs.ModelId
			GROUP BY Models.ModelId 
)  

--SELECT max(NumberOfFaults) AS "Max Faults Per Model"  
--FROM FaultiestCTE;  

SELECT
Models.Name as Model,
(SELECT max(NumberOfFaults)  
FROM FaultiestCTE) AS [Times Serviced],
ISNULL(SUM((OrderParts.Quantity*Parts.Price)),0.00) AS [Parts Total]
FROM Orders 
JOIN OrderParts ON OrderParts.OrderId=Orders.OrderId
JOIN Parts ON OrderParts.PartId=Parts.PartId
RIGHT JOIN Jobs ON Orders.JobId=Jobs.JobId
JOIN Models ON Models.ModelId=Jobs.ModelId
WHERE Models.ModelId IN (
			SELECT Models.ModelId FROM Models
			JOIN Jobs ON Models.ModelId=Jobs.ModelId
			GROUP BY Models.ModelId
			HAVING COUNT(JobId)=(SELECT max(NumberOfFaults)  
FROM FaultiestCTE))
GROUP BY Models.Name

			
			
			