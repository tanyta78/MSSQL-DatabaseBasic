SELECT 
J.JobId,
ISNULL(SUM((Quantity*Price)),0.00) as Total
FROM Orders AS o
JOIN OrderParts as op ON o.OrderId=op.OrderId
JOIN Parts ON op.PartId=Parts.PartId
RIGHT JOIN Jobs AS J ON J.JobId=O.JobId
WHERE Status='Finished'
GROUP BY J.JobId
order by Total desc,J.JobId