SELECT 
CONCAT(FirstName,' ',LastName) as Client,
DATEDIFF(day,issuedate,'2017-04-24')as [Days going],
Status
FROM Clients
JOIN Jobs ON Clients.ClientId=Jobs.ClientId
WHERE Jobs.Status<>'Finished'