CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR (50), @word VARCHAR (50)) 
RETURNS BIT
AS
BEGIN
     DECLARE @index INT = 1
     DECLARE @length INT = LEN(@word)
     DECLARE @letter CHAR(1)

     WHILE (@index <= @length)
     BEGIN
          SET @letter = SUBSTRING(@word, @index, 1)
          IF (CHARINDEX(@letter, @setOfLetters) > 0)
             SET @index = @index + 1
          ELSE
             RETURN 0
     END
     RETURN 1
END 
--
CREATE PROCEDURE udp_TestLoop
AS
BEGIN
	DECLARE @startValue INT = 0;
	DECLARE @maxValue INT = 10;

	WHILE (@startValue < @maxValue)
	BEGIN
		PRINT @startValue
		SET @startValue +=1
	END
END

EXEC udp_TestLoop

BEGIN TRY
	SELECT 0/0
END TRY
BEGIN CATCH
	PRINT 'Error'
END CATCH