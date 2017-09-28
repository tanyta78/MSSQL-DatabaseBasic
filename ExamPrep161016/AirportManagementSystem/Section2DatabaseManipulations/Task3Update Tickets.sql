UPDATE Tickets
SET Price=Price*1.5
WHERE Tickets.TicketID IN (
select T.TicketID
from Flights as f
join  Tickets as t on f.FlightID=t.FlightID
where f.AirlineID in (
SELECT top 1 AirlineID
FROM Airlines
order by Rating desc))