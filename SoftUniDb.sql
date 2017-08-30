CREATE DATABASE SoftUni;

CREATE TABLE Towns
(
Id int not null primary key identity(1,1),
Name varchar(30)not null
)

CREATE TABLE Addresses
(
Id int not null identity(1,1),
AddressText text,
TownId int 
)

CREATE TABLE Departments
(
Id int not null identity(1,1),
Name varchar(30)not null
)

CREATE TABLE Employees
(
Id int not null identity(1,1),
FirstName varchar(30),
MiddleName varchar(30),
LastName varchar(30),
JobTitle varchar(50),
DepartmentId int,
HireDate date,
Salary money,
AddressId int
)

ALTER TABLE Towns
ADD CONSTRAINT PK_Towns PRIMARY KEY(Id)

ALTER TABLE Addresses
ADD CONSTRAINT PK_Addresses PRIMARY KEY(Id)

ALTER TABLE Addresses
ADD CONSTRAINT FK_TownId
FOREIGN KEY (TownId) REFERENCES Towns(Id)

ALTER TABLE Departments
ADD CONSTRAINT PK_Departments PRIMARY KEY(Id)

ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY(Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_DepartmentId
FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_AddressId
FOREIGN KEY (AddressId) REFERENCES Addresses(Id)