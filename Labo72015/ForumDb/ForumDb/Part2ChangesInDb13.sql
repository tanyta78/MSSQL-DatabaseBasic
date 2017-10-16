--1.	Create a table Towns(Id, Name). 
CREATE TABLE Towns
(
Id int IDENTITY PRIMARY KEY,
Name varchar(50)
)

ALTER TABLE Users
ADD TownId int 

ALTER TABLE Users
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)
--2.	Execute the following SQL script (it should pass without any errors):
INSERT INTO Towns(Name) VALUES ('Sofia'), ('Berlin'), ('Lyon')
UPDATE Users SET TownId = (SELECT Id FROM Towns WHERE Name='Sofia')
INSERT INTO Towns VALUES
('Munich'), ('Frankfurt'), ('Varna'), ('Hamburg'), ('Paris'), ('Lom'), ('Nantes')
--3.	Write and execute a SQL command that changes the town to "Paris" for all users with registration date at Friday.
UPDATE Users
SET TownId =(SELECT Id FROM Towns WHERE Name='Paris')
WHERE DATEPART(WEEKDAY,RegistrationDate)=5
--4.	Write and execute a SQL command that changes the question to “Java += operator” of Answers, answered at Monday or Sunday in February.
UPDATE Answers
SET QuestionId=(SELECT Id FROM Questions WHERE Title='Java += operator')
WHERE DATEPART(MONTH,Answers.CreatedOn)=2 AND (DATEPART(WEEKDAY,Answers.CreatedOn)=1 OR DATEPART(WEEKDAY,Answers.CreatedOn)=2)
--5.	Delete all answers with negative sum of votes.
DELETE FROM Votes
WHERE AnswerId IN
(
    SELECT AnswerId
    FROM Votes
    GROUP BY AnswerId
    HAVING SUM(Value) < 0
);

DELETE FROM Answers
WHERE Answers.Id IN
(
    SELECT AnswerId
    FROM Votes
    GROUP BY AnswerId
    HAVING SUM(Value) < 0
);
--6.	Add a new question holding the following information
INSERT INTO Questions(Title,Content,CreatedOn,UserId,CategoryId)
VALUES
(
'Fetch NULL values in PDO query',
'When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?',
 GETDATE(),
 (SELECT Id FROM Users WHERE Username='darkcat'),
 (SELECT Id FROM Categories WHERE Name='Databases')
)
--7.	Find the count of the answers for the users from town

SELECT T.Name AS Town,
       U.Username,
       COUNT(A.Id) AS AnswersCount
FROM Towns T
     JOIN Users U ON U.TownId = T.Id
     JOIN Answers A ON A.UserId = U.Id
GROUP BY T.Name,
         U.Username
ORDER BY AnswersCount DESC,Username