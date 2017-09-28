CREATE PROCEDURE usp_SubmitReview(@CustomerID INT, @ReviewContent VARCHAR(255),@ReviewGrade INT,@AirlineName VARCHAR(30))
AS
BEGIN TRAN
DECLARE @currentAirlineId INT=(SELECT AirlineID
		FROM Airlines
		WHERE Airlines.AirlineName=@AirlineName);

IF(@currentAirlineId IS NULL)
	BEGIN
	ROLLBACK;
	THROW 50001,'Airline does not exist.',1;
	RETURN;
	END

IF(@ReviewGrade < 0 OR @ReviewGrade > 10)
    BEGIN
      RAISERROR('Invalid review grade.', 16, 1); RETURN;
	END

DECLARE @ReviewID INT = ISNULL((SELECT MAX(ReviewID) FROM CustomerReviews),0)+1;


INSERT INTO CustomerReviews VALUES (@ReviewID,@ReviewContent,@ReviewGrade,@currentAirlineId,@CustomerID)

COMMIT
