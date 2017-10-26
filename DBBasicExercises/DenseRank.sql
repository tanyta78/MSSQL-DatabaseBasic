SELECT salaries.DepartmentID,salaries.Salary 
FROM(		
		SELECT 
			DepartmentID,
			MAX(Salary) as Salary,
			DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) as Rank
		FROM Employees 
		GROUP BY DepartmentID,Salary
		)as salaries
WHERE Rank=3

--
SELECT sel.ContinentCode,
       sel.CurrencyCode AS CurrencyCode,
       sel.CurrencyUs AS CurrencyUsage
FROM
(
    SELECT c.ContinentCode,
           cr.CurrencyCode,
           COUNT(cr.Description) AS CurrencyUs,
           DENSE_RANK() OVER(PARTITION BY c.ContinentCode ORDER BY COUNT(cr.CurrencyCode) DESC) AS rankk
    FROM Currencies cr
         JOIN Countries c ON cr.CurrencyCode = c.CurrencyCode
    GROUP BY c.ContinentCode,
             cr.CurrencyCode
    HAVING COUNT(cr.Description) > 1
) AS sel
WHERE sel.rankk = 1
ORDER BY ContinentCode;
