CREATE DATABASE Movies;

CREATE TABLE Directors
(
Id int not null primary key,
DirectorName varchar(30) not null,
Notes varchar(500)
);

CREATE TABLE Genres
(
Id int not null primary key,
GenreName varchar(30) not null,
Notes varchar(500)
)

CREATE TABLE Categories
(
Id int not null primary key,
CategoryName varchar(30) not null,
Notes varchar(500)
)

CREATE TABLE Movies
(
Id int not null primary key,
Title varchar(30) not null,
DirectorId int FOREIGN KEY REFERENCES Directors(Id),
CopyrightYear TIMESTAMP,
Length int,
GenreId int FOREIGN KEY REFERENCES Genres(Id),
CategoryId int FOREIGN KEY REFERENCES Categories(Id),
Rating int,
Notes varchar(500)
)

INSERT INTO Directors(Id,DirectorName)
VALUES (1,'AAA'),(2,'BBB'),(3,'CCC'),(4,'DDD'),(5,'EEE')
INSERT INTO Genres(Id,GenreName)
VALUES (1,'Rock'),(2,'Pop'),(3,'Country'),(4,'Jazz'),(5,'HipHop')
INSERT INTO Categories(Id,CategoryName)
VALUES (1,'New'),(2,'Hot'),(3,'Top10'),(4,'LastMonth'),(5,'Bad')
INSERT INTO Movies(Id,Title,DirectorId,GenreId,CategoryId)
VALUES (1,'ddd',1,1,1),(2,'fff',2,2,1),(3,'eee',3,2,1),(4,'sss',4,3,5),(5,'aaa',1,1,2)