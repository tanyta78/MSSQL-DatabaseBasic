--Problem 19.	*Scalar Function: Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
RETURNS TABLE
AS
return
WITH prices AS (
	SELECT Cash, (ROW_NUMBER() OVER(ORDER BY ug.Cash desc)) as RowNum from UsersGames ug
	join Games g on ug.GameId = g.Id
	WHERE g.Name = @gameName
)
select SUM(Cash) [SumCash] FROM prices WHERE RowNum % 2 = 1

--Problem 20.	Trigger
SELECT u.Username,
g.Name,
Cash,
I.Name as [Item Name]
FROM UsersGames AS ug
join Games g on ug.GameId = g.Id
JOIN Items I ON I.MinLevel<=ug.Level
JOIN Users AS u ON u.Id=ug.UserId