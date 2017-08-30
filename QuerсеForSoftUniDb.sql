USE [SoftUni]
GO
--2.	Find All Information About Departments--
SELECT [DepartmentID]
      ,[Name]
      ,[ManagerID]
  FROM [dbo].[Departments]

--3.	Find all Department Names--
SELECT [Name]
        FROM [dbo].[Departments]

--4.	Find Salary of Each Employee--
SELECT FirstName,LastName,Salary
FROM Employees

--5.	Find Full Name of Each Employee--
SELECT FirstName,MiddleName,LastName
FROM Employees

--6.	Find Email Address of Each Employee--
SELECT FirstName+'.'+LastName+'@softuni.bg' AS [FullEmailAddress]
FROM Employees

--7.	Find All Different Employee�s Salaries--
SELECT DISTINCT Salary 
FROM Employees

--8.	Find all Information About Employees whose job title is �Sales Representative�--
SELECT *
FROM Employees
WHERE JobTitle='Sales Representative'

--9.	Find Names of All Employees by Salary in Range[20000,30000]
SELECT FirstName,LastName,JobTitle
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

--10.Find the full name of all employees whose salary is 25000, 14000, 12500 or 23600. 
SELECT FirstName+' '+MiddleName+' '+LastName AS FullName
FROM Employees
WHERE Salary=25000 OR Salary=14000 OR Salary=12500 OR Salary=23600
 
--11.	 Find All Employees Without Manager
SELECT FirstName,LastName
FROM Employees
WHERE ManagerID IS NULL

--12.	 Find All Employees with Salary More Than 50000
SELECT FirstName,LastName,Salary
FROM Employees
WHERE Salary>50000
ORDER BY Salary DESC

--13.	 Find 5 Best Paid Employees.
SELECT TOP 5 FirstName,LastName
FROM Employees
ORDER BY Salary DESC

--14.	Find All Employees Except Marketing
SELECT FirstName,LastName
FROM Employees
WHERE NOT DepartmentID=4

/*15.	Sort Employees Table
Write a SQL query to sort all records in the Employees table by the following criteria: 
�	First by salary in decreasing order
�	Then by first name alphabetically
�	Then by last name descending
�	Then by middle name alphabetically*/
SELECT *
FROM Employees
ORDER BY Salary DESC,FirstName,LastName DESC,MiddleName

--16.	 Create View Employees with Salaries
CREATE VIEW V_EmployeeSSalaries AS
SELECT FirstName,LastName,Salary
FROM Employees


--17.	Create View Employees with Job Titles
CREATE VIEW V_EmployeeNameJobTitle AS 
SELECT CONCAT(FirstName,' ',MiddleName,' ',LastName)AS[FullName],JobTitle
--SELECT FirstName+' '+ISNULL(MiddleName,'')+' '+LastName AS [FullName],JobTitle
FROM Employees

--18.	 Distinct Job Titles
SELECT DISTINCT JobTitle
FROM Employees

--19.	Find First 10 Started Projects
SELECT TOP (10)*
FROM Projects
ORDER BY StartDate,Name

--20.	 Last 7 Hired Employees
SELECT TOP(7) FirstName,LastName,HireDate
FROM Employees
ORDER BY HireDate DESC

--21.	Increase Salaries
SELECT Salary
FROM Employees

UPDATE Employees
SET Salary=Salary*1.12
WHERE DepartmentID=1 OR DepartmentID=2 OR DepartmentID=4 OR DepartmentID=11

SELECT Salary
FROM Employees