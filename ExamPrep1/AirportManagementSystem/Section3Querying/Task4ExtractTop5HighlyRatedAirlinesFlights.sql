SELECT TOP(5)
A.AirlineID,
A.AirlineName,
A.Nationality,
A.Rating
FROM Airlines AS A
WHERE A.AirlineID IN (
	SELECT AirlineID
	FROM Flights
)
ORDER BY A.Rating DESC,A.AirlineID