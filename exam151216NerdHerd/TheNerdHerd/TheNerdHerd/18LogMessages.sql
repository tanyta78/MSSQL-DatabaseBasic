CREATE TRIGGER tr_DeletedMessages ON Messages AFTER DELETE 
AS
BEGIN
 INSERT INTO MessageLogs(Id, Content, SentOn, ChatId, UserId)
SELECT d.Id, d.Content, d.SentOn, d.ChatId, d.UserId FROM DELETED AS d

END