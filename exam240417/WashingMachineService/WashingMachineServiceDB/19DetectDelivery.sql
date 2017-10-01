CREATE TRIGGER DeliveryStatusChanged ON Orders
AFTER UPDATE
AS
  IF (EXISTS(SELECT * FROM inserted WHERE inserted.Delivered=1) 
  BEGIN
  --TO DO
  UPDATE 
  END