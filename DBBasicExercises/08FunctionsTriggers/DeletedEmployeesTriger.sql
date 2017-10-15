CREATE TABLE Deleted_Employees
(
EmployeeId INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
MiddleName VARCHAR(50),
JobTitle VARCHAR(50),
DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentID),
Salary MONEY
)

CREATE TRIGGER TR_EmployeesDeleted
ON Employees
FOR DELETE
AS
BEGIN
   
    INSERT INTO Deleted_Employees(FirstName, LastName, MiddleName, JobTitle, DepartmentID, Salary)
    SELECT d.FirstName,d.LastName,d.MiddleName,d.JobTitle,d.DepartmentID,d.Salary
    FROM deleted AS d
END