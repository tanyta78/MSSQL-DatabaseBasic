select 
c.Name as [CategoryName],
COUNT(*)as [Employees Number]
 from Categories c
join Departments d on d.Id=c.DepartmentId
join Employees e on e.DepartmentId=d.Id
group by c.Id,c.Name
order by c.Name