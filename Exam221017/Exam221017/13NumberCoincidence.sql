SELECT U.Username
FROM Categories C
     JOIN Reports r ON r.CategoryId = c.Id
     JOIN Users u ON u.Id = r.UserId
WHERE(Username LIKE '[0-9]%'
      AND CONVERT(VARCHAR(1),c.id) = LEFT(u.Username, 1))
     OR (Username LIKE '%[0-9]'
         AND CONVERT(VARCHAR(1),c.id) = RIGHT(u.Username, 1)) 
 ORDER BY U.Username     
         

