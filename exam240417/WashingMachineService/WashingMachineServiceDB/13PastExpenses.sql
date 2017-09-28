SELECT 
Jobs.JobId,
SUM((Quantity*Price)) as Total
FROM Jobs
JOIN Orders ON Jobs.JobId=Orders.JobId
JOIN OrderParts ON Orders.OrderId=OrderParts.OrderId
JOIN Parts ON OrderParts.PartId=Parts.PartId
WHERE Status='Finished'
GROUP BY Jobs.JobId
order by Total desc,JobId