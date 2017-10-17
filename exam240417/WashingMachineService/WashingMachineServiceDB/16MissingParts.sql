SELECT P.PartId,
       P.Description,
       SUM(PN.Quantity) AS Required,
       AVG(p.StockQty) AS [In Stock],
       ISNULL(SUM(op.Quantity), 0) AS [Ordered]
FROM Parts AS P
     JOIN PartsNeeded PN ON PN.PartId = P.PartId
     JOIN Jobs AS J ON J.JobId = PN.JobId
     LEFT JOIN Orders AS O ON O.JobId = J.JobId
     LEFT JOIN OrderParts AS OP ON OP.OrderId = O.OrderId
WHERE J.Status <> 'Finished'
GROUP BY p.PartId,
         P.Description
HAVING AVG(P.StockQty) + ISNULL(SUM(OP.Quantity), 0) < SUM(PN.Quantity)
ORDER BY P.PartId