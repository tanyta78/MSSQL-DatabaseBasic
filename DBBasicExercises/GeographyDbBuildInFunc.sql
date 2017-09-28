USE Geography
GO

--Problem 10.	Countries Holding ‘A’ 3 or More Times
SELECT CountryName,IsoCode
FROM Countries
WHERE (LEN(CountryName)-LEN(REPLACE(CountryName,'a','')))>=3
ORDER BY IsoCode

--Problem 11.	 Mix of Peak and River Names
SELECT 
		PeakName,
		RiverName,
		CONCAT(LOWER(SUBSTRING(PeakName,1,LEN(PeakName)-1)),LOWER(RiverName)) as Mix
FROM Peaks,Rivers 
WHERE LEFT(RiverName,1)=RIGHT(PeakName,1)
ORDER BY Mix




