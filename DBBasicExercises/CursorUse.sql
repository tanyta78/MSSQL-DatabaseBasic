DECLARE @currentDeposit DECIMAL(8,2)
DECLARE @previousDeposit DECIMAL(8,2)
DECLARE @totalSum DECIMAL(8,2)

--declare cursor
DECLARE wizardCursor CURSOR FOR SELECT DepositAmount FROM WizzardDeposits

--open cursor
OPEN wizardCursor
FETCH NEXT FROM wizardCursor INTO @currentDeposit

--real use in while loop
WHILE (@@FETCH_STATUS = 0)
BEGIN
    IF (@previousDeposit IS NOT NULL)
	   BEGIN
		  SET @totalSum +=(@previousDeposit-@currentDeposit)
	   END
    SET @previousDeposit=@currentDeposit
    FETCH NEXT FROM wizardCursor INTO @currentDeposit
END

--close cursor
CLOSE wizardCursor
DEALLOCATE wizardCursor

SELECT @totalSum