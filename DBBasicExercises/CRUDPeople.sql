CREATE TABLE People
(
Id int not null primary key identity(1,1) ,
Name nvarchar(200) not null,
Picture varbinary(2000),
Height FLOAT (2),
Weight FLOAT(2),
Gender varchar(3) not null check(Gender in('m','f')),
Birthdate date not null,
Biography text
)
INSERT INTO People(Name,Picture,Height,Weight,Gender,Birthdate,Biography)
VALUES ('Ivan',null,1.8,120,'m','1983-11-11','rejnogfoj4rog4jig'),
('Stoqn',null,1.78,83.3,'m','1992-3-3','jehfdhfujekwjf'),
('Dragan',null,2.02,100,'m','1992-4-21','edjfn3ehfhuer'),
('Gana',null,1.72,65,'f','1988-2-12','erikfjroee'),
('BabaYaga',null,1.32,34,'f','1700-1-1','dekdjoeijf');