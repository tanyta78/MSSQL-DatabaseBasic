SELECT 
FirstName,
Age,
PhoneNumber
FROM Customers
JOIN Countries ON Countries.Id=Customers.CountryId
WHERE (Age>=21 AND CHARINDEX('AN',FirstName)>0)
OR (PhoneNumber LIKE '%38' AND Countries.Name<>'Greece')
ORDER BY FirstName, Age DESC