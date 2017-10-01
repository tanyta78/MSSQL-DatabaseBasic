CREATE PROC udp_SendMessage(@UserId INT,@ChatId INT,@Content VARCHAR(200))
AS
BEGIN
	BEGIN TRANSACTION
	INSERT INTO [Messages](Content,SentOn,ChatId,UserId)
	VALUES (@Content,CAST(GETDATE()AS DATE),@ChatId,@UserId)

	IF @UserId NOT IN (SELECT UserId FROM [UsersChats] WHERE ChatId = @ChatId)
    BEGIN
		ROLLBACK
	    RAISERROR('There is no chat with that user!', 16, 1)
		RETURN
	END
	COMMIT
	--DECLARE @NextId INT = ISNULL((SELECT MAX(Id) FROM [Messages]), 0) + 1
END