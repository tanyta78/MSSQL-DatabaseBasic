USE SoftUni
GO

--Problem 1.	Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT 
		FirstName,
		LastName
	FROM Employees
	WHERE Salary>35000
END
--GO
--EXEC usp_GetEmployeesSalaryAbove35000

--Problem 2.	Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@Number MONEY)
AS
BEGIN
	SELECT 
		FirstName,
		LastName
	FROM Employees
	WHERE Salary>=@Number
END

--Problem 3.	Town Names Starting With
CREATE PROC usp_GetTownsStartingWith(@StartsWith varchar(20))
AS
BEGIN
	SELECT Name AS Town
	FROM Towns
	WHERE SUBSTRING(Name,1,LEN(@StartsWith))=@StartsWith
END

--Problem 4.	Employees from Town
CREATE PROC usp_GetEmployeesFromTown (@TownName VARCHAR(50))
AS
BEGIN
	SELECT 
	FirstName,
	LastName
	FROM Employees AS e
	join Addresses as a ON E.AddressID=A.AddressID
	join Towns AS t ON a.TownID=t.TownID
	WHERE t.Name=@TownName
END

--Problem 5.	Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)
	IF @salary<30000 SET @salaryLevel='Low'
	ELSE IF @salary>50000 SET @salaryLevel='High'
	ELSE SET @salaryLevel='Average'
	RETURN @salaryLevel
END

--Problem 6.	Employees by Salary Level
CREATE PROC usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(10))
AS
BEGIN
	SELECT 
	FirstName,
	LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary)=@salaryLevel
END

--Problem 7.	Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR (50), @word VARCHAR (50)) 
RETURNS BIT
AS
BEGIN
     DECLARE @index INT = 1
     DECLARE @length INT = LEN(@word)
     DECLARE @letter CHAR(1)

     WHILE (@index <= @length)
     BEGIN
          SET @letter = SUBSTRING(@word, @index, 1)
          IF (CHARINDEX(@letter, @setOfLetters) > 0)
             SET @index = @index + 1
          ELSE
             RETURN 0
     END
     RETURN 1
END 

--Problem 8.	* Delete Employees and Departments
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (
			SELECT EmployeeID FROM Employees AS E
			  JOIN Departments AS d
			  ON E.DepartmentID=d.DepartmentID
			WHERE D.Name IN ('Production','Production Control')
			)

UPDATE Employees
SET ManagerID=NULL
WHERE ManagerID IN (
			SELECT EmployeeID FROM Employees AS E
			  JOIN Departments AS d
			  ON E.DepartmentID=d.DepartmentID
			WHERE D.Name IN ('Production','Production Control')
			)

UPDATE Departments
SET ManagerID=NULL
WHERE ManagerID IN (
			SELECT EmployeeID FROM Employees AS E
			  JOIN Departments AS d
			  ON E.DepartmentID=d.DepartmentID
			WHERE D.Name IN ('Production','Production Control')
			)

DELETE FROM Employees
WHERE EmployeeID IN(
					SELECT EmployeeID FROM Employees AS E
					  JOIN Departments AS d
					  ON E.DepartmentID=d.DepartmentID
					WHERE D.Name IN ('Production','Production Control')
					)

DELETE FROM Departments
WHERE Name IN ('Production','Production Control')

--Problem 9.	Employees with Three Projects
CREATE PROC usp_AssignProject(@EmployeeID INT, @ProjectID INT) AS
	BEGIN TRANSACTION

	INSERT INTO EmployeesProjects values(@EmployeeID, @ProjectID);
	IF( SELECT count(*) from EmployeesProjects
		WHERE EmployeeID=@EmployeeID)>3
		BEGIN
		ROLLBACK;
		RAISERROR('The employee has too many projects!',16,1)
		RETURN;
		END

	COMMIT

