USE SoftUni
GO

--Problem 1.	Find Names of All Employees by First Name
SELECT [FirstName]
      ,[LastName]
FROM Employees
WHERE FirstName LIKE 'sa%'

--Problem 2.	  Find Names of All employees by Last Name 
SELECT FirstName,LastName
FROM Employees
WHERE LastName LIKE '%ei%'

--Problem 3.	Find First Names of All Employees
SELECT FirstName
FROM Employees
WHERE (DepartmentID=3 OR DepartmentID=10) AND
		YEAR(HireDate) BETWEEN 1995AND 2005


--Problem 4.	Find All Employees Except Engineers
SELECT FirstName,LastName
FROM Employees
WHERE JobTitle NOT LIKE '%ENGINEER%'

--Problem 5.	Find Towns with Name Length
SELECT Name
FROM Towns
WHERE LEN(Name)=5 OR LEN(Name)=6
ORDER BY Name

--Problem 6.	 Find Towns Starting With
SELECT TownID,Name
FROM Towns
WHERE LEFT(Name,1) LIKE '[MKBE]'
ORDER BY Name

--Problem 7.	 Find Towns Not Starting With
SELECT TownID,Name
FROM Towns
WHERE LEFT(Name,1) NOT LIKE '[RBD]'
ORDER BY Name

--Problem 8.	Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000
AS
SELECT FirstName,LastName
FROM Employees
WHERE YEAR(HireDate)>2000

--Problem 9.	Length of Last Name
SELECT FirstName,LastName
FROM Employees
WHERE LEN(LastName)=5
