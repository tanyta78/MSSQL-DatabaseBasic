SELECT OpenDate,
       Description,
       u.Email AS [Reported Email]
FROM Reports r
	LEFT JOIN Categories C ON C.Id = R.CategoryId
     JOIN Departments D ON D.Id = C.DepartmentId
     JOIN Users u ON u.Id = r.UserId
WHERE(CloseDate IS NULL)
     AND (LEN(Description) > 20
          AND (charindex('str',Description)<>0))
     AND (d.Name IN('Infrastructure', 'Emergency', 'Roads Maintenance'))
ORDER BY OpenDate,
         [Reported Email],
         r.Id;

SELECT OpenDate,
       Description,
       u.Email AS [Reported Email]
FROM Reports r
	LEFT JOIN Users U ON U.Id=R.Id
	LEFT JOIN Employees E ON E.Id=r.EmployeeId
	JOIN Departments D ON D.Id=E.DepartmentId
WHERE(CloseDate IS NULL)
     AND (LEN(Description) > 20
          AND (charindex('str',Description)<>0))
     AND (d.Name IN('Infrastructure', 'Emergency', 'Roads Maintenance'))
ORDER BY OpenDate,
         [Reported Email],
         r.Id;

	