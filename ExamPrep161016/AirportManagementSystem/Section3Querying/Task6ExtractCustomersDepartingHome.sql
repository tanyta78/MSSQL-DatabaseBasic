SELECT DISTINCT
c.CustomerID,
CONCAT(FirstName,' ',LastName)AS FullName,
tw.TownName as HomeTowm
FROM Flights AS f
 JOIN Tickets AS t
 ON t.FlightID=f.FlightID
 JOIN Customers AS c
 ON t.CustomerID=c.CustomerID
 JOIN Towns AS TW
 ON C.HomeTownID=TW.TownID
 JOIN Airports AS A
 ON A.AirportID=F.OriginAirportID
WHERE C.HomeTownID=A.TownID
ORDER BY C.CustomerID

