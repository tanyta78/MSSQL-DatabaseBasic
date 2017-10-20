CREATE VIEW v_UserWithCountries 
AS
SELECT 
CONCAT(FirstName,' ',LastName)AS CustomerName,
Age,
Gender,
Countries.Name AS CountryName
FROM Customers 
JOIN Countries ON Customers.CountryId=Countries.Id