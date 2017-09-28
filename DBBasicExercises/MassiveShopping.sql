SELECT *
INTO ItemsShouldBuy
FROM Items
WHERE (Items.Id BETWEEN 251 AND 299) OR (Items.Id BETWEEN 501 AND 539)

SELECT 
Users.Id as [UserId],
Users.Username,
Games.Name,
UsersGames.Cash,
UsersGames.Id as[UserGameId],
Level
INTO Buyers
FROM UsersGames
JOIN Users ON Users.Id=UsersGames.UserId
JOIN Games ON UsersGames.GameId=Games.Id
WHERE Users.Username IN ('baleremuda','loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos' )
AND Games.Name='Bali'

drop table Bills

select 
Buyers.UserGameId,
ItemsShouldBuy.Id as [Item Id]
into BuyersItems
from Buyers
join ItemsShouldBuy on Buyers.Level>ItemsShouldBuy.MinLevel

select
UserGameId ,
sum(Price)as Bill 
into Bills
from BuyersItems
join ItemsShouldBuy on BuyersItems.[Item Id]=ItemsShouldBuy.Id
group by UserGameId

insert into UserGameItems(UserGameId,ItemId) 
SELECT * from BuyersItems

UPDATE UsersGames
SET Cash -= (SELECT bill FROM Bills)
WHERE UsersGames.Id = (Bills.UserGameId)