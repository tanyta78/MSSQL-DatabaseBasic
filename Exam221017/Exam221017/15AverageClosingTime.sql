SELECT 
[Department Name],
CASE WHEN [Average Duration]=0 THEN 'no info'
    else CONVERT(varchar, [Average Duration])
    end AS [Average Duration]
FROM
(
SELECT D.Name AS [Department Name],
       ISNULL(AVG(DATEDIFF(day, r.OpenDate, r.CloseDate)), 0) 
        AS [Average Duration]
FROM Reports r
     JOIN Categories c ON c.Id = r.CategoryId
     JOIN Departments D ON D.Id = C.DepartmentId
GROUP BY DepartmentId,
         D.Name)AS ACT
ORDER BY ACT.[Department Name]

