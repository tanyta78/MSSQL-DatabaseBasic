
--with cte_openReports as (
--select distinct EmployeeId ,COUNT(*) AS OpenReports
--from Reports
--where YEAR(OpenDate)=2016 
--group by EmployeeId)

--with cte_closedReports as (
--select distinct EmployeeId ,COUNT(*) AS ClosedReports
--from Reports
--where YEAR(ISNULL(CloseDate,0))=2016
--group by EmployeeId)

SELECT concat(FirstName, ' ', LastName) AS Name,
CONCAT(ISNULL(ClosedReports,0),'/',ISNULL(OpenReports,0)) as [Closed Open Reports]
FROM Employees e
left join 
(
    SELECT DISTINCT
           EmployeeId,
           COUNT(*) AS OpenReports
    FROM Reports
    WHERE YEAR(OpenDate) = 2016
    GROUP BY EmployeeId
) AS OpenR ON OpenR.EmployeeId = E.Id
left join
(
    SELECT DISTINCT
           EmployeeId,
           COUNT(*) AS ClosedReports
    FROM Reports
    WHERE YEAR(ISNULL(CloseDate, 0)) = 2016
    GROUP BY EmployeeId
) AS ClosedR ON ClosedR.EmployeeId = e.Id
WHERE (ClosedReports<>0 OR OpenReports<>0) 
ORDER BY Name,E.Id
