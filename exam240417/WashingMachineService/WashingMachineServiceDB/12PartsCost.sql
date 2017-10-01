SELECT ISNULL(SUM(p.Price  * op.Quantity), 0.00) AS [Parts Total]
  FROM Orders AS o
  JOIN OrderParts AS op ON o.OrderId = op.OrderId
  JOIN Parts AS p ON op.PartId = p.PartId
WHERE DATEDIFF(DAY, o.IssueDate, '2017-04-24') <= 21