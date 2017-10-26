CREATE TRIGGER TR_ReportsComleted ON Reports
FOR UPDATE
AS
     BEGIN
         UPDATE Reports
           SET
               StatusId = (select id from Status where label='completed')
         WHERE id IN
         (
             SELECT Id
             FROM inserted
         );
     END;