SELECT DISTINCT
t.CustomerID,
CONCAT(c.FirstName,' ',c.LastName) AS FullName,
2016-DATEPART(YEAR,c.DateOfBirth) AS Age
FROM Tickets AS t
JOIN Flights AS f ON t.FlightID=f.FlightID AND f.Status='Departing'
JOIN Customers AS c ON t.CustomerID=c.CustomerID
ORDER BY Age,T.CustomerID