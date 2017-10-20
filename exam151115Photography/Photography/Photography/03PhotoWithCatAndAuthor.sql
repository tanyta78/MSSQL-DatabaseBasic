SELECT 
Title,
Link,
Description,
C.Name AS [CategoryName],
U.FullName AS [Author]
FROM Photographs AS P
JOIN Categories AS C ON P.CategoryId=C.Id
JOIN Users AS U ON U.Id=P.UserId
WHERE Description IS NOT NULL
ORDER BY Title

