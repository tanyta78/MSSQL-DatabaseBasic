-- to do-
-- not finish

UPDATE Cameras 
  SET Price += (
 				 (
				  SELECT AVG(Price) 
				    FROM Cameras AS c 
				   WHERE ManufacturerId = c.ManufacturerId
				 ) 
				 * 
				 (
				  (SELECT LEN(Name)/100.00 FROM Manufacturers AS m WHERE ManufacturerId = m.Id)
				 )
			   )

SELECT sub.Model
	   , sub.Price
	   , sub.ManufacturerId 
  FROM (
		 SELECT Model
				,Price
				,ManufacturerId
				, Rank() OVER (PARTITION BY ManufacturerId ORDER BY Price DESC ) AS ranks
		   FROM Cameras
       ) AS sub 
WHERE ranks <= 3 AND Price IS NOT NULL

SELECT sub.Model AS [Model]
	   , sub.Price AS [Price]
	   , sub.ManufacturerId AS [ManufacturerId]
  FROM (
		 SELECT c.Model
				, c.Price 
				, c.ManufacturerId
				, RANK() OVER (PARTITION BY c.ManufacturerId ORDER BY c.Price DESC) AS ranks
		   FROM Cameras AS c
		) AS sub
 WHERE sub.ranks BETWEEN 1 AND 3
AND sub.Price IS NOT NULL