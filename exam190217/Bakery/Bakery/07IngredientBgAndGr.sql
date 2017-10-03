SELECT TOP(15) Ingredients.Name,Description ,Countries.Name 
FROM Ingredients
JOIN Countries ON Countries.Id=Ingredients.OriginCountryId
WHERE Countries.Name IN ('Bulgaria','Greece')
ORDER BY Ingredients.Name,Countries.Name 