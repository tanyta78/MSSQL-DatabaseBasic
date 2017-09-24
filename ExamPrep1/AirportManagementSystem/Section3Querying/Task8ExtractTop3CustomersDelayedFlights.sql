SELECT TOP(3)
t.CustomerID,
CONCAT(c.FirstName,' ',c.LastName)AS FullName,
t.Price AS TicketPrice,
a.AirportName AS Destination
FROM Tickets AS t
JOIN Flights AS f ON t.FlightID=f.FlightID AND f.Status='Delayed'
JOIN Customers AS c ON t.CustomerID=c.CustomerID
JOIN Airports AS a ON f.DestinationAirportID=a.AirportID
ORDER BY TicketPrice DESC,CustomerID