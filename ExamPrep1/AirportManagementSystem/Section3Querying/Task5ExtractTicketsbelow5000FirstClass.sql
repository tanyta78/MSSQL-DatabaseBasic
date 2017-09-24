SELECT 
TicketID,
AirportName AS Destination,
FirstName+' '+LastName  AS CustomerName
FROM Tickets
JOIN Flights ON Tickets.FlightID=Flights.FlightID
JOIN Airports ON Flights.DestinationAirportID=Airports.AirportID
JOIN Customers ON Tickets.CustomerID=Customers.CustomerID
WHERE Price<5000 AND Class='First'