SELECT distinct
t.CustomerID,
CONCAT(c.FirstName,' ',c.LastName) AS FullName,
2016 - DATEPART(YEAR,c.DateOfBirth) AS Age
FROM Tickets AS t
JOIN Flights AS f ON t.FlightID=f.FlightID AND f.Status='Arrived'
JOIN Customers AS c ON t.CustomerID=c.CustomerID
WHERE (2016 - DATEPART(YEAR,c.DateOfBirth))<21
ORDER BY Age DESC,t.CustomerID asc