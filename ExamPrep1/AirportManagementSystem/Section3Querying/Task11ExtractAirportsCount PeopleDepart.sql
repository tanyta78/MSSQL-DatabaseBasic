SELECT f.OriginAirportID as AirportID,
a.AirportName,
count(*) as Passengers
FROM Tickets AS t
JOIN Flights AS f ON t.FlightID=f.FlightID AND f.Status='Departing'
JOIN Airports AS a ON f.OriginAirportID=a.AirportID
group by f.OriginAirportID,a.AirportName
having count(*)>0
order by f.OriginAirportID