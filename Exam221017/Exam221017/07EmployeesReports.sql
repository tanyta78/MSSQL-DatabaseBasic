
SELECT e.FirstName,
       e.LastName,
       r.Description,
       FORMAT(r.OpenDate, 'yyyy-MM-dd') AS OpenDate
FROM Reports r
     JOIN Employees e ON r.EmployeeId = e.Id
WHERE EmployeeId IS NOT NULL
ORDER BY EmployeeId,
         OpenDate,
         r.Id;