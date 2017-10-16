--Problem 1.	All Question Titles
SELECT Title 
FROM Questions
ORDER BY Title 

--Problem 2.	Answers in Date Range

SELECT Content,
       CreatedOn
FROM Answers
WHERE CreatedOn BETWEEN '2012-06-15' AND '2013-03-22'
ORDER BY CreatedOn,Id;

--Problem 3.	Users with "1/0" Phones
SELECT Username,
       LastName,
       CASE
           WHEN PhoneNumber IS NULL
           THEN 0
           ELSE 1
       END AS [Has Phone]
FROM Users
ORDER BY LastName,
         Id;

--Problem 4.	Questions with their Author
SELECT Q.Title AS [Question Title],
       u.Username AS Author
FROM Questions Q
     JOIN Users U ON U.Id = Q.UserId
ORDER BY [Question Title];

--Problem 5.	Answers with their Question with their Category and User
SELECT TOP (50) A.Content AS [Answer Content],
                A.CreatedOn,
                U.Username AS [Answer Author],
                Q.Title AS [Question Title],
                c.Name AS [Category Name]
FROM Answers A
     JOIN Questions Q ON Q.Id = A.QuestionId
     JOIN Categories C ON C.Id = Q.CategoryId
     JOIN Users U ON U.Id = A.UserId
ORDER BY [Category Name],
         [Answer Author],
         CreatedOn;

--Problem 6.	Category with Questions
SELECT C.Name AS Category,
       q.Title AS Question,
       q.CreatedOn
FROM Categories C
     LEFT JOIN Questions Q ON Q.CategoryId = C.Id
ORDER BY [Category],
         [Question];

--Problem 7.	*Users without PhoneNumber and Questions
SELECT U.Id,
       U.Username,
       U.FirstName,
       U.PhoneNumber,
       U.RegistrationDate,
       U.Email
FROM Users U
     LEFT JOIN Questions Q ON Q.UserId = U.Id
WHERE PhoneNumber IS NULL
      AND Q.Id IS NULL
ORDER BY RegistrationDate;

--Problem 8.	Earliest and Latest Answer Date

SELECT MIN(CreatedOn) AS MinDate,
       MAX(CreatedOn) AS MaxDate
FROM Answers
WHERE YEAR(CreatedOn) BETWEEN '2012' AND '2014';

--Problem 9.	Find the last ten answers
SELECT TOP (10) Content AS Answer,
                CreatedOn,
                Username
FROM Answers A
     JOIN Users U ON U.Id = A.UserId
ORDER BY CreatedOn DESC;

--Problem 10.	Not Published Answers from the First and Last Month
SELECT A.Content AS [Answer Content],
       q.Title AS Question,
       c.Name AS [Category]
	
FROM Answers A
     JOIN Questions Q ON Q.Id = A.QuestionId
     LEFT JOIN Categories C ON C.Id = Q.CategoryId
WHERE YEAR(A.CreatedOn) =
	   (
		  SELECT TOP (1) YEAR(CreatedOn)
		  FROM Answers A
		  ORDER BY CreatedOn DESC
	   )
      AND (MONTH(A.CreatedOn) =
          (
              SELECT TOP (1) MONTH(CreatedOn)
              FROM Answers A
              WHERE YEAR(A.CreatedOn) =
              (
                  SELECT TOP (1) YEAR(CreatedOn)
                  FROM Answers A
                  ORDER BY CreatedOn DESC
              )
              ORDER BY MONTH(CreatedOn) DESC
          )
           OR MONTH(A.CreatedOn) =
          (
              SELECT TOP (1) MONTH(CreatedOn)
              FROM Answers A
              WHERE YEAR(A.CreatedOn) =
              (
                  SELECT TOP (1) YEAR(CreatedOn)
                  FROM Answers A
                  ORDER BY CreatedOn DESC
              )
              ORDER BY MONTH(CreatedOn)
          ))
		AND
		  A.IsHidden = 1
ORDER BY C.Name;

--Problem 11.	Answers count for Category
SELECT C.Name AS Category,
       COUNT(A.Id) AS [Answers Count]
FROM Categories C
     LEFT JOIN Questions Q ON Q.CategoryId = C.Id
     LEFT JOIN Answers A ON A.QuestionId = Q.Id
GROUP BY C.Name
ORDER BY [Answers Count]DESC

--Problem 12.	Answers Count by Category and Username
SELECT 
C.Name AS [Category],
u.Username,
u.PhoneNumber,
COUNT(a.Id) AS [Answers Count]
FROM Answers A
LEFT JOIN Questions Q ON Q.Id=A.QuestionId
LEFT JOIN Categories C ON C.Id=Q.CategoryId
LEFT JOIN Users U ON U.Id=A.UserId
WHERE U.PhoneNumber IS NOT NULL
GROUP BY C.Name,U.Username,U.PhoneNumber
ORDER BY [Answers Count],Username
--
SELECT 
C.Name AS [Category],
u.Username,
u.PhoneNumber,
COUNT(a.Id) AS [Answers Count]
FROM Categories C
RIGHT JOIN Questions Q ON Q.CategoryId=C.Id
RIGHT JOIN Answers A ON A.QuestionId=Q.Id
RIGHT JOIN Users U ON U.Id=A.UserId
WHERE U.PhoneNumber IS NOT NULL
GROUP BY C.Name,U.Username,U.PhoneNumber
ORDER BY [Answers Count],Username

