--Problem 10.	Find Full Name
CREATE PROC usp_GetHoldersFullName
AS
BEGIN

SELECT FirstName +' ' + LastName AS 'Full Name'
FROM AccountHolders

END

--Problem 11.	People with Balance Higher Than
CREATE PROC usp_GetHoldersWithBalanceHigherThan(@Number MONEY)
AS
BEGIN

SELECT FirstName,
	   LastName  
FROM AccountHolders AS AH
INNER JOIN 
(SELECT AccountHolderId,SUM(Balance) AS [SUM] FROM Accounts AS A 
	GROUP BY AccountHolderId
	HAVING SUM(Balance) > @Number) as Balances
ON AH.Id = Balances.AccountHolderId
END

--Problem 12.	Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue(@Sum MONEY,@YearlyInterestRate FLOAT,@NumberOfYears INT)
RETURNS DECIMAL(10,4)
AS
BEGIN
DECLARE @FutureValueSum DECIMAL(10,4)
SET @FutureValueSum=@Sum*(POWER(1+@YearlyInterestRate,@NumberOfYears))
RETURN @FutureValueSum
END

--Problem 13.	Calculating Interest
CREATE PROC usp_CalculateFutureValueForAccount(@AccountId INT,@InterestRate FLOAT)
AS
BEGIN

SELECT 
	A.Id AS [Account Id],
	ah.FirstName,
	ah.LastName,
	a.Balance AS[Current Balanse],
	dbo.ufn_CalculateFutureValue(a.Balance,@InterestRate,5) as [Balance in 5 years]
FROM Accounts AS A
INNER JOIN AccountHolders AS AH
ON
A.AccountHolderId=AH.Id
WHERE A.Id=@AccountId

END

--Problem 14.	Deposit Money
CREATE PROCEDURE usp_DepositMoney (@accountId INT, @moneyAmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION;
	
	UPDATE Accounts SET Balance = Balance + @moneyAmount
	WHERE Id = @accountId;
	IF @@ROWCOUNT <> 1
	BEGIN
		ROLLBACK;
		RAISERROR('Invalid account!', 16, 1);
		RETURN;
	END;  

	COMMIT;
END

--Problem 15.	Withdraw Money
CREATE PROC usp_WithdrawMoney (@accountId INT, @moneyAmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION; 
	UPDATE Accounts SET Balance=Balance-@moneyAmount
	WHERE Id=@accountId;

	IF @@ROWCOUNT <> 1
	BEGIN
		ROLLBACK;
		RAISERROR('Invalid account!', 16, 1);
		RETURN;
	END; 

	IF(SELECT TOP 1 Balance FROM Accounts WHERE Id=@accountId)<0
	BEGIN
	ROLLBACK;
		RAISERROR('Insufficient balance!', 16, 1);
		RETURN;
	END; 

	COMMIT;
END

--Problem 16.	Money Transfer
CREATE PROC usp_TransferMoney(@senderId INT, @receiverId INT, @amount MONEY)
AS
BEGIN 
	BEGIN TRANSACTION
	EXEC dbo.usp_DepositMoney @receiverId,@amount
	EXEC dbo.usp_WithdrawMoney @senderId,@amount

	IF(SELECT TOP 1 Balance FROM Accounts WHERE Id=@senderId)<0
	BEGIN
	ROLLBACK;
		RAISERROR('Insufficient balance!', 16, 1);
		RETURN;
	END; 

	IF(@amount<0)
	BEGIN
	ROLLBACK;
		RAISERROR('Negative amount!!!', 16, 1);
		RETURN;
	END; 

	COMMIT;
END

--Problem 17.	Create Table Logs

CREATE TABLE Logs
(
LogId INT IDENTITY,
AccountId INT,
OldSum MONEY,
NewSum MONEY,
CONSTRAINT PK_Logs PRIMARY KEY (LogId),
CONSTRAINT FK_Logs_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(Id)
)

CREATE TRIGGER T_Accounts_After_Update ON Accounts AFTER UPDATE
AS
BEGIN
--inserted включва данните които са променени
--deleted включва данните преди промяната
	INSERT INTO Logs(AccountId,OldSum,NewSum)
	SELECT	i.Id,
			d.Balance,
			i.Balance
	FROM inserted AS i
	INNER JOIN deleted AS d ON d.Id=i.Id

	
END

--Problem 18.	Create Table Emails

CREATE TABLE NotificationEmails
(
Id INT IDENTITY,
Recipient INT,
Subject VARCHAR(50),
Body VARCHAR(100),
CONSTRAINT PK_NotificationEmails PRIMARY KEY (Id),
)

CREATE TRIGGER T_Logs_After_Update ON Logs AFTER INSERT
AS
BEGIN
	INSERT INTO NotificationEmails(Recipient,Subject,Body)
	SELECT		i.AccountId ,
				'Balance change for account: ' + CAST(i.AccountId AS VARCHAR(10)) ,
				'On '+cast(GETDATE() as VARCHAR(30))+' your balance was changed from '+CAST(i.OldSum AS VARCHAR)+' to '+CAST(i.NewSum AS VARCHAR)+'.'
	FROM inserted AS i
	
END

EXEC usp_DepositMoney 1,1000
SELECT*FROM NotificationEmails