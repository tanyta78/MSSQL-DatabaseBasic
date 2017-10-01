SELECT 
Username,
FullName,
BirthDate,
ISNULL(Title,'No photos') as Photo
FROM Users
LEFT JOIN Photographs ON Photographs.UserId=Users.Id
WHERE MONTH(BirthDate)=1
ORDER BY FullName