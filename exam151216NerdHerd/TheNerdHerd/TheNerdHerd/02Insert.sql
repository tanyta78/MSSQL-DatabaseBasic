INSERT INTO [Messages](Content, SentOn, ChatId, UserId)
     SELECT  CONCAT(u.Age, '-', u.Gender, '-', l.Latitude, '-', l.Longitude)
			 , CONVERT(DATE, GETDATE()) 
			 , CASE u.Gender 
					WHEN 'F' THEN CEILING(SQRT(u.Age * 2))
					WHEN 'M' THEN CEILING(POWER(u.Age / 18, 3))
			   END
			 , u.Id
   	   FROM Users AS u
	   JOIN Locations AS l ON u.LocationId = l.Id
WHERE u.Id BETWEEN 10 AND 20