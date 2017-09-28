DELETE FROM OrderParts
WHERE OrderId=19

DELETE FROM PartsNeeded
WHERE JobId=(
SELECT j.JobId FROM Orders as o
JOIN Jobs as j ON o.JobId=j.JobId
WHERE OrderId=19)

DELETE FROM Orders
WHERE OrderId=19

DELETE FROM Jobs
WHERE JobId=(
SELECT j.JobId FROM Orders as o
JOIN Jobs as j ON o.JobId=j.JobId
WHERE OrderId=19)

