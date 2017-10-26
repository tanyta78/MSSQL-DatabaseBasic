
--SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Name,
--       COUNT(DISTINCT u.Id) AS [Users Number]
--FROM Employees e
--     JOIN Reports r ON r.EmployeeId = e.Id
--     JOIN Users u ON u.Id = r.UserId
--GROUP BY e.Id,
--         e.FirstName,
--         e.LastName
--ORDER BY [Users Number] DESC,
--         name;

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Name,
       COUNT(DISTINCT r.UserId) AS [Users Number]
FROM Employees e
     left JOIN Reports r ON r.EmployeeId = e.Id
GROUP BY e.Id,
         e.FirstName,
         e.LastName
ORDER BY [Users Number] DESC,
         name 