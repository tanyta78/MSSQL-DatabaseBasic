SELECT 
SUM((OrderParts.Quantity*Parts.Price)) AS [Parts Total]
FROM OrderParts
JOIN Parts ON OrderParts.PartId=Parts.PartId
JOIN Orders ON OrderParts.OrderId=Orders.OrderId
WHERE DATEDIFF(DAY,Orders.IssueDate,'2017-04-24')<=21