/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT DepartmentId
FROM Employees

SELECT LastName, DepartmentId
   FROM [SoftUni].[dbo].[Employees]
   WHERE DepartmentId=5

SELECT LastName,Salary
FROM Employees
WHERE Salary<=20000

SELECT LastName FROM Employees
WHERE NOT (ManagerID=3 OR ManagerID=4)

SELECT FirstName + ' '+LastName AS[Full Name],
			Salary,
			HireDate,
			ManagerID
FROM Employees
WHERE (DepartmentID=1 AND Salary<40000)
OR (DepartmentID=3 AND Salary<30000)

SELECT FirstName + ' '+LastName AS[Full Name],
			Salary,
			HireDate,
			ManagerID
FROM Employees
WHERE Salary BETWEEN 10000 AND 40000

SELECT FirstName + ' '+LastName AS[Full Name],
	DepartmentID
FROM Employees
WHERE DepartmentID IN (1,3,5)

SELECT FirstName + ' '+LastName AS[Full Name],
	DepartmentID,
	Salary
FROM Employees
WHERE NOT Salary<=40000

SELECT FirstName + ' '+LastName AS[Full Name],
	ManagerID,
	Salary
FROM Employees
WHERE ManagerID IS NULL

SELECT FirstName + ' '+LastName AS[Full Name],
	ManagerID,
	Salary
FROM Employees
WHERE ManagerID IS NOT NULL

SELECT LastName,Salary
FROM Employees
ORDER BY Salary

SELECT LastName,Salary,ManagerID
FROM Employees
WHERE ManagerID=3
ORDER BY Salary DESC