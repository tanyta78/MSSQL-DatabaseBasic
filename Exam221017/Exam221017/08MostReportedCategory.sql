
SELECT c.Name AS CategoryName,
       COUNT(*) AS ReportsNumber
FROM Reports r
     JOIN Categories c ON c.Id = r.CategoryId
GROUP BY CategoryId,
         c.Name
ORDER BY ReportsNumber DESC,
         c.Name;