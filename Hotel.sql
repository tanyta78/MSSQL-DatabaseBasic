CREATE DATABASE Hotel;

CREATE TABLE Employees
(
Id int not null primary key,
FirstName varchar(20),
LastName varchar(20),
Title varchar(20),
Notes text
)
 
CREATE TABLE Customers
(
AccountNumber varchar(30) not null primary key,
FirstName varchar(20),
LastName varchar(20),
PhoneNumber varchar(15),
EmergencyName varchar (15),
EmergencyNumber varchar(15),
Notes text
)

CREATE TABLE RoomStatus
(
RoomStatus varchar(10) primary key,
Notes text
)

CREATE TABLE RoomTypes
(
RoomType varchar(10) primary key,
Notes text
)

CREATE TABLE BedTypes
(
BedType varchar(10) primary key,
Notes text
)

CREATE TABLE Rooms
(
RoomNumber int primary key,
RoomType varchar(10) FOREIGN KEY REFERENCES RoomTypes(RoomType),
BedType varchar(10)FOREIGN KEY REFERENCES BedTypes(BedType),
Rate int,
RoomStatus varchar(10)FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
Notes text
)

CREATE TABLE Payments
(
Id int primary key,
EmployeeId int FOREIGN KEY REFERENCES Employees(Id),
PaymentDate date,
AccountNumber varchar(30) FOREIGN KEY REFERENCES Customers(AccountNumber),
FirstDateOccupied date,
LastDateOccupied date,
TotalDays int,
AmountCharged money,
TaxRate int,
TaxAmount money,
Notes text
)

CREATE TABLE Occupancies
(
Id int primary key,
EmployeeId int FOREIGN KEY REFERENCES Employees(Id),
DateOccupied date,
AccountNumber varchar(30) FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber int FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied varchar(10),
PhoneCharge varchar(15),
Notes text
)

INSERT INTO Employees(Id,FirstName)
VALUES (1,'IVAN'),(2,'DIDOD'),(3,'AISHA')

INSERT INTO Customers(AccountNumber,FirstName)
VALUES ('12345678','BOBO'),('23456789','GOGO'),('00000000','VOVO')

INSERT INTO RoomStatus(RoomStatus)
VALUES ('READY'),('FOR CLEAN'),('OCCUPIED')

INSERT INTO RoomTypes(RoomType)
VALUES ('SINGLE'),('DOUBLE'),('APARTMENT')

INSERT INTO BedTypes(BedType)
VALUES ('SINGLE'),('DOUBLE'),('ONEANDHALF')

INSERT INTO Rooms(RoomNumber,RoomType,BedType,RoomStatus)
VALUES (11,'SINGLE','SINGLE','FOR CLEAN'),(12,'SINGLE','SINGLE','OCCUPIED'),(13,'DOUBLE','DOUBLE','READY')

INSERT INTO Payments(Id,EmployeeId)
VALUES (1,2),(2,3),(3,2)

INSERT INTO Occupancies(Id,EmployeeId,AccountNumber)
VALUES (1,3,'12345678'),(2,3,'12345678'),(3,3,'12345678')