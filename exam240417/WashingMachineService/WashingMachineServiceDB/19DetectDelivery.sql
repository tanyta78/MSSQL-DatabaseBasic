CREATE TRIGGER tr_DeliveryStatusChanged ON Orders
AFTER UPDATE
AS
     BEGIN
         DECLARE @OLDSTATUS INT=
         (
             SELECT DELIVERED
             FROM deleted
         );
         DECLARE @NEWSTATUS INT=
         (
             SELECT DELIVERED
             FROM inserted
         );
         IF(@OLDSTATUS = 0  AND @NEWSTATUS = 1)
             BEGIN
                 UPDATE Parts
                   SET
                       StockQty+=OP.Quantity
                 FROM Parts AS p
                      JOIN OrderParts OP ON OP.PartId = p.PartId
                      JOIN Orders O ON O.OrderId = OP.OrderId
                      JOIN inserted I ON I.OrderId = O.OrderId
                      JOIN deleted D ON D.OrderId = O.OrderId;
         END;
     END;

 