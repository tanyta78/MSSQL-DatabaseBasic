--Problem 29.	Peaks and Mountains
SELECT
PeakName,
MountainRange,
Elevation
FROM Peaks
JOIN Mountains ON Peaks.MountainId=Mountains.Id 
ORDER BY Elevation desc,PeakName

--Problem 30.	Peaks with Their Mountain, Country and Continent
SELECT 
PeakName,
MountainRange,
CountryName,
ContinentName
FROM Peaks AS p
JOIN Mountains AS m ON P.MountainId=M.Id 
LEFT JOIN MountainsCountries AS MC ON M.ID = MC.MountainId
JOIN Countries AS C ON MC.CountryCode=C.CountryCode
JOIN Continents AS CC ON C.ContinentCode=CC.ContinentCode
ORDER BY PeakName,CountryName

--Problem 31.	Rivers by Country
SELECT 
C.CountryName,
CC.ContinentName,
ISNULL(COUNT(RiverId),0) AS [RiversCount],
ISNULL(sum(R.Length),0) AS[TotalLength]
FROM Countries AS C
LEFT JOIN CountriesRivers AS CR ON C.CountryCode=CR.CountryCode
JOIN Continents AS CC ON C.ContinentCode=CC.ContinentCode
LEFT JOIN Rivers AS R ON CR.RiverId=R.Id
GROUP BY C.CountryCode,C.CountryName,CC.ContinentName
ORDER BY [RiversCount] DESC,[TotalLength] DESC, CountryName

--Problem 32.	Count of Countries by Currency
SELECT
CU.CurrencyCode,
CU.Description AS Currency, 
COUNT(C.CountryName) AS NumberOfCountries
FROM Currencies AS CU
LEFT JOIN Countries AS C ON C.CurrencyCode=CU.CurrencyCode
GROUP BY CU.CurrencyCode,cu.Description
ORDER BY NumberOfCountries DESC,Currency

--Problem 33.	Population and Area by Continent
SELECT 
CC.ContinentName,
SUM(CAST(ISNULL(c.AreaInSqKm, 0) AS BIGINT)) AS CountriesArea,
SUM(CAST(ISNULL(c.[Population], 0) AS BIGINT)) AS CountriesPopulation
FROM Continents AS CC
JOIN Countries AS C ON C.ContinentCode=CC.ContinentCode
GROUP BY CC.ContinentName
ORDER BY CountriesPopulation DESC

--Problem 34.	Monasteries by Country
CREATE TABLE Monasteries
(
Id INT IDENTITY(1,1),
Name Varchar(50),
CountryCode char(2),
CONSTRAINT PK_Monasteries PRIMARY KEY (Id),
CONSTRAINT FK_Monasteries_Countries FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)
)
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')


--ALTER TABLE Countries
--ADD IsDeleted Bit DEFAULT 0

--UPDATE Countries
--SET IsDeleted = 0

update Countries
SET IsDeleted = 1
where CountryCode in (
					select CountryCode
					from CountriesRivers
					group by CountryCode
					having count(RiverId)>3
)

SELECT 
Monasteries.Name,
Countries.CountryName
FROM Monasteries
JOIN Countries ON Monasteries.CountryCode=Countries.CountryCode
WHERE Countries.IsDeleted<>1
ORDER BY Monasteries.Name

--Problem 35.	Monasteries by Continents and Countries
UPDATE Countries
SET CountryName='Burma'
WHERE CountryName='Myanmar'

INSERT INTO Monasteries(Name,CountryCode) values
('Hanga Abbey',(
	select CountryCode
	from Countries
	where CountryName='Tanzania')
	)

	INSERT INTO Monasteries(Name,CountryCode) values
('Myin-Tin-Daik',(
	select CountryCode
	from Countries
	where CountryName='Myanmar')
	)

	SELECT 
	co.ContinentName,
	CountryName,
	COUNT(m.Name)as MonasteriesCount
	FROM Countries as c
	left JOIN Monasteries AS m ON m.CountryCode=c.CountryCode
	join Continents as co on co.ContinentCode=c.ContinentCode
	where IsDeleted=0
	group by co.ContinentName,CountryName
	order by MonasteriesCount desc,CountryName