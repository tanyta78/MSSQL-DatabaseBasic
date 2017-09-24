SELECT top(5)
FlightID,
DepartureTime,
ArrivalTime,
origin.AirportName AS Origin,
destination.AirportName AS Destination
FROM	(SELECT TOP(5) *
			FROM Flights  
			WHERE Status='Departing'
			ORDER BY DepartureTime DESC) AS f
JOIN Airports AS origin ON f.OriginAirportID=origin.AirportID
JOIN  Airports AS destination ON f.DestinationAirportID=destination.AirportID
ORDER BY DepartureTime ,FlightID
