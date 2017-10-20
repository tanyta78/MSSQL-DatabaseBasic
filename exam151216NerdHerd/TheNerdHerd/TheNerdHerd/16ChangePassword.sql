CREATE PROC udp_ChangePassword(@Email VARCHAR(30),@NewPassword VARCHAR(20))
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE [Credentials]
	SET Credentials.Password=@NewPassword
	WHERE Credentials.Email=@Email

	IF @Email NOT IN (SELECT Email FROM [Credentials])
	BEGIN
		ROLLBACK
		RAISERROR('The email does''t exist!', 16, 1)
		RETURN
	END
    COMMIT
END