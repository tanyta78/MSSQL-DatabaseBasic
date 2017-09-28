CREATE TABLE Users
(
Id bigint not null primary key identity(1,1) ,
Username varchar(30) not null unique,
Password varchar(26) not null,
ProfilePicture varbinary(max),
LastLoginTime date,
IsDeleted bit
)
INSERT INTO Users(Username,Password,ProfilePicture,LastLoginTime,IsDeleted)
VALUES ('Ivan','dgfkdpes',null,'1983-11-11','true'),
('Stoqn','dddd',null,'1992-3-3','false'),
('Dragan','eeee',null,'1992-4-21','false'),
('Gana','fgfgf',null,'1988-2-12','true'),
('BabaYaga','ededed',null,'1700-1-1','true');