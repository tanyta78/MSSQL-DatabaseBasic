CREATE TABLE Monasteries
(Id          INT IDENTITY(1, 1),
 Name        VARCHAR(50),
 CountryCode CHAR(2),
 CONSTRAINT PK_Monasteries PRIMARY KEY(Id),
 CONSTRAINT FK_Monasteries_Countries FOREIGN KEY(CountryCode) REFERENCES Countries(CountryCode)
);
INSERT INTO Monasteries
(Name,
 CountryCode
)
VALUES
('Rila Monastery “St. Ivan of Rila”',
 'BG'
),
('Bachkovo Monastery “Virgin Mary”',
 'BG'
),
('Troyan Monastery “Holy Mother''s Assumption”',
 'BG'
),
('Kopan Monastery',
 'NP'
),
('Thrangu Tashi Yangtse Monastery',
 'NP'
),
('Shechen Tennyi Dargyeling Monastery',
 'NP'
),
('Benchen Monastery',
 'NP'
),
('Southern Shaolin Monastery',
 'CN'
),
('Dabei Monastery',
 'CN'
),
('Wa Sau Toi',
 'CN'
),
('Lhunshigyia Monastery',
 'CN'
),
('Rakya Monastery',
 'CN'
),
('Monasteries of Meteora',
 'GR'
),
('The Holy Monastery of Stavronikita',
 'GR'
),
('Taung Kalat Monastery',
 'MM'
),
('Pa-Auk Forest Monastery',
 'MM'
),
('Taktsang Palphug Monastery',
 'BT'
),
('S?mela Monastery',
 'TR'
);


--ALTER TABLE Countries
--ADD IsDeleted Bit DEFAULT 0

--UPDATE Countries
--SET IsDeleted = 0

UPDATE Countries
  SET
      IsDeleted = 1
WHERE CountryCode IN
(
    SELECT CountryCode
    FROM CountriesRivers
    GROUP BY CountryCode
    HAVING COUNT(RiverId) > 3
);
SELECT Monasteries.Name,
       Countries.CountryName
FROM Monasteries
     JOIN Countries ON Monasteries.CountryCode = Countries.CountryCode
WHERE Countries.IsDeleted <> 1
ORDER BY Monasteries.Name;