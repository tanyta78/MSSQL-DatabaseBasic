SELECT 
Jobs.ModelId,
Models.Name,
CONCAT(avg(datediff(DAY,IssueDate,FinishDate)),' days')as [Average Servise Time]
FROM Models
JOIN Jobs ON Jobs.ModelId=Models.ModelId
WHERE Status='Finished'
group by Jobs.ModelId,Models.Name
order by avg(datediff(DAY,IssueDate,FinishDate))