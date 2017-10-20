CREATE PROC usp_PlaceOrder(@jobId INT,@partSerialNum VARCHAR(50),@quantity INT)
AS
BEGIN
	DECLARE @partId	INT
	DECLARE @orderId INT
	DECLARE @partQuantity INT
	BEGIN TRAN
	--find @partId by @partSerialNum if not exist @errorMsg=ID 50014 "Part not found!"
	SET @partId = (
				SELECT top 1 PartId
				FROM Parts
				WHERE Parts.SerialNumber=@partSerialNum)
	IF(@partId IS NULL)
			BEGIN;
			THROW 51014, 'Part not found!', 1; 
			ROLLBACK;
			END
	--if @jobId not exist in Jobs set @errorMsg=ID 50013 "Job not found!"
	IF((SELECT top 1 JobId 
		FROM Jobs
		WHERE Jobs.JobId=@jobId)IS NULL)
			BEGIN;
			THROW 51013, 'Job not found!', 1; 
			ROLLBACK;
			END
	--if job.status is finished set @errorMsg=ID 50011 "This job is not active!"
	IF((SELECT Jobs.Status 
		FROM Jobs 
		WHERE Jobs.JobId=@jobId)='Finished')
			BEGIN;
			THROW 51011, 'This job is not active!', 1; 
			ROLLBACK;
			END
	--if @quantity is zero or negative set @errorMsg ID 50012 "Part quantity must be more than zero!"
	IF(@quantity<=0)
			BEGIN;
			THROW 51012, 'Part quantity must be more than zero!', 1; 
			ROLLBACK;
			END
	--take orderId
	SET @orderId=(SELECT top 1 OrderId 
		FROM Orders
		WHERE Orders.JobId=@jobId AND Orders.IssueDate IS NULL)
	--if order for @jobId NOT exist in Orders and issue date is null
		--insert into Orders values jobId,issue date null,quantity
	IF(	@orderId IS NULL)
		BEGIN
		INSERT INTO Orders VALUES(@jobId,NULL,@quantity)
		END
	ELSE
	--if order for @jobId exist in Orders and issue date is null
		BEGIN
	--if part not in OrderParts add @partId with @quantity 
	--else add @quantity to previous one
		SET @partQuantity=(SELECT top 1 OrderParts.Quantity 
							FROM OrderParts
							WHERE OrderParts.PartId=@partId AND OrderParts.OrderId=@orderId)
		IF(@partQuantity IS NULL)
			BEGIN
			INSERT INTO OrderParts(OrderId,PartId,Quantity) VALUES (@orderId,@partId,@quantity)
			END
		ELSE
			BEGIN
			UPDATE OrderParts
			SET OrderParts.Quantity=@partQuantity+@quantity
			WHERE OrderParts.PartId=@partId AND OrderParts.OrderId=@orderId
			END
		END
	COMMIT
END

