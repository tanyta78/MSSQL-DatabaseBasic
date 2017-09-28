SELECT
Models.Name as Model,
(SELECT TOP 1
			COUNT(JobId)
			FROM Models
			JOIN Jobs ON Models.ModelId=Jobs.ModelId
			GROUP BY Models.ModelId
			ORDER BY COUNT(JobId) DESC) AS [Times Serviced],
SUM((OrderParts.Quantity*Parts.Price)) AS [Parts Total]
FROM Models
JOIN Jobs ON Models.ModelId=Jobs.ModelId
JOIN Orders ON Orders.JobId=Jobs.JobId
JOIN OrderParts ON OrderParts.OrderId=Orders.OrderId
JOIN Parts ON OrderParts.PartId=Parts.PartId
WHERE Models.ModelId IN (
			SELECT Models.ModelId FROM Models
			JOIN Jobs ON Models.ModelId=Jobs.ModelId
			GROUP BY Models.ModelId
			HAVING COUNT(JobId)=

			(SELECT TOP 1(COUNT(JobId))
			FROM Models
			JOIN Jobs ON Models.ModelId=Jobs.ModelId
			GROUP BY Models.ModelId
			ORDER BY COUNT(JobId) DESC))
GROUP BY Models.Name

			
			
			