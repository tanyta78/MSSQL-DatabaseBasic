USE Geography GO

--22.	 All Mountain Peaks
SELECT PeakName
FROM Peaks
ORDER BY PeakName

--23.	 Biggest Countries by Population
SELECT TOP(30) CountryName,Population
FROM Countries
WHERE ContinentCode='EU'
ORDER BY Population DESC,CountryName

--24.	 *Countries and Currency (Euro / Not Euro)
SELECT CountryName,CountryCode,'Currency'=
CASE WHEN CurrencyCode='EUR' THEN 'Euro' ELSE 'Not Euro' END 
FROM Countries
ORDER BY CountryName

USE Diablo GO
--25.	 All Diablo Characters
SELECT Name
FROM Characters
ORDER BY Name

