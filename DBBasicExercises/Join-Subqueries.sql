--Problem 1.	Employee Address
SELECT	TOP(5) EmployeeID,
		JobTitle,
		e.AddressID,
		AddressText
FROM  Employees AS e
INNER JOIN Addresses AS a
ON e.AddressID=a.AddressID
ORDER BY e.AddressID

--Problem 2.	Addresses with Towns
SELECT TOP(50)
		FirstName,
		LastName,
		t.Name as Town,
		AddressText
		FROM Employees AS e
		JOIN Addresses AS a ON e.AddressID=a.AddressID
		JOIN Towns AS t ON a.TownID=t.TownID

ORDER BY e.FirstName,LastName

--Problem 3.	Sales Employee
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	d.Name AS DepartmentName
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
WHERE d.Name='Sales'
ORDER BY EmployeeID

--Problem 4.	Employee Departments
SELECT TOP(5)
	EmployeeID,
	FirstName,
	Salary,
	d.Name AS DepartmentName
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
WHERE Salary>15000
ORDER BY e.DepartmentID

--Problem 5.	Employees Without Project
SELECT top(3)
		e.EmployeeID,
		e.FirstName
FROM Employees AS e
left JOIN EmployeesProjects AS ep ON e.EmployeeID=ep.EmployeeID
where ep.ProjectID is null

--Problem 6.	Employees Hired After
select 
FirstName,
LastName,
HireDate,
d.Name AS DeptName
from Employees as e
join Departments as d on e.DepartmentID=d.DepartmentID
where (d.Name='Sales' or d.Name='Finance')and HireDate>'01-01-1999'
order by HireDate


--Problem 7.	Employees with Project
select top(5)
e.EmployeeID,
FirstName,
p.Name
from Employees as e
join EmployeesProjects as ep on e.EmployeeID=ep.EmployeeID
join Projects as p on ep.ProjectID=p.ProjectID
where p.StartDate>'2002-08-13' and p.EndDate is null
order by EmployeeID

--Problem 8.	Employee 24
select 
		e.EmployeeID,
		FirstName,
		p.Name as ProjectName
from Employees as e
join EmployeesProjects as ep on e.EmployeeID=ep.EmployeeID
left join Projects as p on ep.ProjectID=p.ProjectID and p.StartDate<'2005-01-01'
where e.EmployeeID=24 
--
SELECT e.EmployeeID, e.FirstName,
CASE
	WHEN p.StartDate > '20050101' THEN NULL
	ELSE p.name
	END AS ProjectName
FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
INNER JOIN projects AS p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24


--Problem 9.	Employee Manager

select 
e.EmployeeID,
e.FirstName,
m.EmployeeID as ManagerID,
m.FirstName as ManagerName
from Employees as e
JOIN Employees as m on m.EmployeeID=e.ManagerID
WHERE e.ManagerID IN (3,7)
ORDER BY EmployeeID

--Problem 10.	Employee Summary
select top(50)
e.EmployeeID,
e.FirstName+' '+e.LastName as EmployeeName,
m.FirstName+' '+m.LastName as ManagerName,
d.Name as DepartmentName
from Employees as e
JOIN Employees as m on m.EmployeeID=e.ManagerID
JOIN Departments as d on e.DepartmentID=d.DepartmentID
order by EmployeeID

--Problem 11.	Min Average Salary
select top(1 )avg(e.Salary)as avgSalary
from Employees as e
group by DepartmentID
order by avgSalary

use Geography
go

--Problem 12.	Highest Peaks in Bulgaria
select 
mc.CountryCode,
m.MountainRange,
p.PeakName,
p.Elevation
from MountainsCountries as mc
join Countries as c on mc.CountryCode=c.CountryCode
join Mountains as m on mc.MountainId=m.Id
join Peaks as p on mc.MountainId=p.MountainId
where mc.CountryCode='BG' and p.Elevation>2835
order by p.Elevation desc

--Problem 13.	Count Mountain Ranges
select 
mc.CountryCode,
count(m.MountainRange)as MontainRanges
from MountainsCountries as mc
join Countries as c on mc.CountryCode=c.CountryCode
join Mountains as m on mc.MountainId=m.Id
group by mc.CountryCode
having mc.CountryCode in ('BG','RU','US')

--Problem 14.	Countries with Rivers
SELECT top(5)
c.CountryName,
r.RiverName
FROM Countries AS c
left JOIN CountriesRivers AS cr ON cr.CountryCode=c.CountryCode
left JOIN Rivers AS r ON cr.RiverId=r.Id
join Continents as cont on c.ContinentCode=cont.ContinentCode
where cont.ContinentName='Africa'
order by c.CountryName

--Problem 15.	*Continents and Currencies
SELECT
  sel.ContinentCode,
  sel.CurrencyCode AS CurrencyCode,
  sel.CurrencyUs AS CurrencyUsage
     FROM (SELECT c.ContinentCode,
                  cr.CurrencyCode,
                  COUNT(cr.Description) AS CurrencyUs,
                  DENSE_RANK() over (partition by c.ContinentCode order by COUNT(cr.CurrencyCode) desc) as rankk
             FROM  Currencies cr
             JOIN Countries c ON cr.CurrencyCode = c.CurrencyCode
             GROUP BY c.ContinentCode, cr.CurrencyCode
             HAVING  COUNT(cr.Description) > 1) as sel
where sel.rankk = 1 
ORDER BY ContinentCode

--Problem 16.	Countries without any Mountains
select count(c.CountryCode)as CountryCode
from Countries as c
left join MountainsCountries as mc on c.CountryCode=mc.CountryCode
where mc.MountainId is null


--Problem 17.	Highest Peak and Longest River by Country
select top(5)
c.CountryName,
max(p.Elevation) as HighestPeakElevation,
max(r.Length) AS LongestRiverLength
from Countries as c
join MountainsCountries as mc on c.CountryCode=mc.CountryCode
join Peaks as p on p.MountainId=mc.MountainId
left join CountriesRivers as cr on c.CountryCode=cr.CountryCode
left join Rivers as r on cr.RiverId=r.Id
group by c.CountryName
order by HighestPeakElevation desc,LongestRiverLength desc,CountryName

--Problem 18.	* Highest Peak Name and Elevation by Country
SELECT TOP 5 A.* FROM(
SELECT
  c.CountryName AS [Country],
  p.PeakName AS [Highest Peak Name],
  p.Elevation AS [Highest Peak Elevation],
  m.MountainRange AS [Mountain]
FROM
  Countries c
  LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
  LEFT JOIN Mountains m ON m.Id = mc.MountainId
  LEFT JOIN Peaks p ON p.MountainId = m.Id
WHERE p.Elevation =
  (SELECT MAX(p.Elevation)
   FROM MountainsCountries mc
     LEFT JOIN Mountains m ON m.Id = mc.MountainId
     LEFT JOIN Peaks p ON p.MountainId = m.Id
   WHERE c.CountryCode = mc.CountryCode)
UNION
SELECT 
  c.CountryName AS [Country],
  '(no highest peak)' AS [Highest Peak Name],
  0 AS [Highest Peak Elevation],
  '(no mountain)' AS [Mountain]
FROM
  Countries c
  LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
  LEFT JOIN Mountains m ON m.Id = mc.MountainId
  LEFT JOIN Peaks p ON p.MountainId = m.Id
WHERE 
  (SELECT MAX(p.Elevation)
   FROM MountainsCountries mc
     LEFT JOIN Mountains m ON m.Id = mc.MountainId
     LEFT JOIN Peaks p ON p.MountainId = m.Id
   WHERE c.CountryCode = mc.CountryCode) IS NULL
   )AS A
ORDER BY [Country], [Highest Peak Name]





