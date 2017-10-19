CREATE TRIGGER tr_products_delete 
    ON Products
    INSTEAD OF DELETE
AS
BEGIN

	DELETE FROM ProductsIngredients
	 WHERE ProductId IN (SELECT d.Id FROM DELETED AS d)

	DELETE FROM Feedbacks
	 WHERE ProductId IN (SELECT d.Id FROM DELETED AS d)

	DELETE FROM Products
	 WHERE Id IN (SELECT d.Id FROM DELETED AS d) 

END



SELECT * FROM ProductsIngredients