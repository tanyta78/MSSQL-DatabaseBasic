SELECT 
ProductId,
CONCAT(C.FirstName,' ',C.LastName) AS CustomerName,
f.Description AS FeedbackDescription
FROM Customers AS C
RIGHT JOIN Feedbacks AS F ON F.CustomerId=C.Id
WHERE C.Id IN(
				SELECT C.Id
				FROM Customers AS C
				RIGHT JOIN Feedbacks AS F ON F.CustomerId=C.Id
				GROUP BY C.Id
				HAVING COUNT(F.Id)>=3)
ORDER BY ProductId,CustomerName,F.Id