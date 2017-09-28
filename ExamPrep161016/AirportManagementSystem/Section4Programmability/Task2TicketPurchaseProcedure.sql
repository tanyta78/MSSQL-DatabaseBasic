CREATE PROCEDURE usp_PurchaseTicket(@CustomerID INT,@FlightID INT,@TicketPrice DECIMAL(8,2),@Class VARCHAR(6),@Seat VARCHAR(5))
AS
--DECLARE @CustomerID INT,@FlightID INT,@TicketPrice DECIMAL(8,2),@Class VARCHAR(6),@Seat VARCHAR(5)
BEGIN TRAN

UPDATE CustomerBankAccounts
	SET Balance-=@TicketPrice
	WHERE CustomerID=@CustomerID;

DECLARE @Balance numeric(10,2)=(SELECT Balance 
FROM CustomerBankAccounts 
WHERE CustomerID=@CustomerID);

IF(@Balance < 0 or @Balance is null)
BEGIN
	ROLLBACK;
	THROW 50001, 'Insufficient bank account balance for ticket purchase.',1;
	RETURN;
END

DECLARE @TicketID INT = ISNULL((SELECT MAX(TicketID) FROM Tickets),0)+1;

INSERT INTO Tickets VALUES(@TicketID,@TicketPrice,@Class,@Seat,@CustomerID,@FlightID);

COMMIT