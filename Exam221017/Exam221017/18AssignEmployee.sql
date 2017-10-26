CREATE PROC usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
AS
BEGIN
DECLARE @employeeDepartmentId int = (SELECT DepartmentId FROM Employees WHERE Employees.Id=@employeeId);
DECLARE @reportDepartmentId int = (SELECT DepartmentId FROM Reports R JOIN Categories C ON R.CategoryId=C.Id WHERE R.Id=@reportId);

IF(@employeeDepartmentId<>@reportDepartmentId)
BEGIN
RAISERROR('Employee doesn''t belong to the appropriate department!',16,1)
RETURN
END

UPDATE Reports
SET EmployeeId=@employeeId
WHERE Id=@reportId

END