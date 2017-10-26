-- DATATA E SAMO DEN I MESEC !!!!

SELECT distinct C.Name
FROM Reports R
     JOIN Categories C ON C.Id = R.CategoryId
WHERE R.Id IN
(
    SELECT R.Id
    FROM Reports R
         JOIN Users U ON U.Id = R.UserId
    WHERE DATEPART(DAY, U.BirthDate) = DATEPART(day, R.OpenDate)
          AND DATEPART(MONTH, U.BirthDate) = DATEPART(MONTH, R.OpenDate)
)
order by c.Name;



