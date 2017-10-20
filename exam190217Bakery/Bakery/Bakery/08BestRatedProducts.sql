SELECT TOP(10) P.Name,P.Description,AVG(Rate) AS AverageRate,COUNT(P.Description) AS FeedbacksAmount
FROM Feedbacks AS F
JOIN Products AS P ON P.Id=F.ProductId
GROUP BY F.ProductId,P.Name,P.Description
ORDER BY AverageRate DESC,FeedbacksAmount DESC