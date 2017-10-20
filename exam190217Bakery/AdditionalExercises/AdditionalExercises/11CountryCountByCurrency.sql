SELECT Currencies.CurrencyCode,
       Currencies.Description AS [Currency],
       COUNT(Countries.CountryCode) AS NumberOfCountries
FROM Currencies
     left JOIN Countries ON Countries.CurrencyCode = Currencies.CurrencyCode
GROUP BY Currencies.CurrencyCode,
         Currencies.Description
ORDER BY NumberOfCountries DESC,
         Currency;