use SoftUni
go

--Problem 13.	Departments Total Salaries
SELECT 
	DepartmentID,
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--Problem 14.	Employees Minimum Salaries
SELECT
	DepartmentID,
	MIN(Salary) AS MinimumSalary
FROM Employees
WHERE (DepartmentID=2 OR DepartmentID=5 OR DepartmentID=7) AND (HireDate>'2000/1/1')
GROUP BY DepartmentID

--Problem 15.	Employees Average Salaries
SELECT * INTO [EmployeesAS] FROM Employees
WHERE [Salary] > 30000
 
DELETE FROM EmployeesAS
WHERE [ManagerID] = 42
 
UPDATE EmployeesAS
SET [Salary] += 5000
WHERE [DepartmentID] = 1
 
SELECT [DepartmentID],
    AVG([Salary]) as [AverageSalary]
FROM EmployeesAS
GROUP BY [DepartmentID]

--Problem 16.	Employees Maximum Salaries
SELECT 
	DepartmentID,
	MAX(Salary) AS MaxSalary
	
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary)NOT BETWEEN 30000 AND 70000

--Problem 17.	Employees Count Salaries
SELECT COUNT(Salary) AS Count
FROM Employees
WHERE ManagerID IS NULL

--Problem 18.	*3rd Highest Salary
		
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

--Problem 19.	**Salary Challenge

SELECT TOP(10) FirstName,LastName,DepartmentID FROM Employees AS e
WHERE Salary>(
				SELECT AVG (Salary)FROM Employees AS emp
				WHERE e.DepartmentID=emp.DepartmentID
				GROUP BY DepartmentID
				)






