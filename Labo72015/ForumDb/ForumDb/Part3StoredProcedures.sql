--Problem 14.	Create a View and a Stored Function
CREATE VIEW V_AllQuestions
AS
(
    SELECT U.Id AS UId,
           Username,
           FirstName,
           LastName,
           Email,
           PhoneNumber,
           RegistrationDate,
           q.Id AS QId,
           Title,
           Content,
           CategoryId,
           UserId,
           CreatedOn
    FROM Questions Q
         JOIN Users U ON U.Id = Q.UserId
);

SELECT * FROM V_AllQuestions
--2.	Using the view above, create a stored function "fn_ListUsersQuestions" that returns a table, holding all users in descending order as first column, along with all titles of their questions (in ascending order), separated by ", " as second column.
--CREATE FUNC 2.	Using the view above, create a stored function "fn_ListUsersQuestions" that returns a table, holding all users in descending order as first column, along with all titles of their questions (in ascending order), separated by ", " as second column.
CREATE FUNCTION fn_ListAllUsersQuestions
(
)
RETURNS @tbl_UsersAds TABLE
(UserName NVARCHAR(MAX),
 AdDates  NVARCHAR(MAX)
)
AS
     BEGIN
         DECLARE UsersCursor CURSOR
         FOR
             SELECT DISTINCT Username
             FROM AllQuestions
             ORDER BY Username DESC;
         OPEN UsersCursor;
         DECLARE @username NVARCHAR(MAX);
         FETCH NEXT FROM UsersCursor INTO @username;
         WHILE @@FETCH_STATUS = 0
             BEGIN
                 DECLARE @titles NVARCHAR(MAX)= NULL;
                 SET @titles =
                 (
                     SELECT STUFF(
                                 (
                                     SELECT ', '+ Title
                                     FROM AllQuestions AS a
                                     WHERE a.Username = @username
							  ORDER BY Title DESC
							   FOR XML PATH('')
                                 ), 1, 2, '')
                 );
                 INSERT INTO @tbl_UsersAds
                 VALUES
                 (@username,
                  @titles
                 );
                 FETCH NEXT FROM UsersCursor INTO @username;
             END;
         CLOSE UsersCursor;
         DEALLOCATE UsersCursor;
         RETURN;
     END;

	select * from fn_ListAllUsersQuestions()