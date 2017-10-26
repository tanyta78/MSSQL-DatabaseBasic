with cte_ranked as(SELECT
	   d.Name as [Department Name],
	   c.Name as [Category Name],
	   COUNT(UserId) as Rank
	    FROM Reports R
	   JOIN Categories C ON C.Id=R.CategoryId
	   JOIN Departments D ON D.Id=C.DepartmentId
	   group by DepartmentId,CategoryId,d.Name,c.Name)


select 
cte_ranked.[Department Name],
cte_ranked.[Category Name],
ROUND(cast(Rank as float)/(sumRank),2)*100 as Persentage
from cte_ranked
join(
select cte_ranked.[Department Name],
sum(cte_ranked.Rank) as sumRank
from
cte_ranked
group by [Department Name])as sumRank on sumRank.[Department Name]=cte_ranked.[Department Name]
order by [Department Name],[Category Name],Persentage
	   

