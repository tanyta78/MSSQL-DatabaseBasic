CREATE DATABASE CarRental;

CREATE TABLE Categories
(
Id int not null primary key,
CategoryName varchar(30) not null,
DailyRate money not null,
WeeklyRate money not null,
MonthlyRate money not null,
WeekendRate money not null
);

CREATE TABLE Cars
(
Id int not null primary key,
PlateNumber varchar(5) not null,
Manifacturer varchar(20),
Model varchar(20),
CarYear int,
CategoryId int FOREIGN KEY REFERENCES Categories(Id) not null,
Doors int,
Picture varbinary,
Condition text,
Available varchar CHECK (Available='Yes' OR Available ='No')
)

CREATE TABLE Employees
(
Id int not null primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Title varchar(20),
Notes text
)

CREATE TABLE Customers
(
Id int not null primary key,
DriverLicenceNumber varchar(20) not null,
FullName varchar(20),
Address varchar(30),
City varchar(20),
ZIPCode int,
Notes text
)

CREATE TABLE RentalOrders
(
Id int not null primary key,
EmployeeId int FOREIGN KEY REFERENCES Employees(Id) not null,
CustomerId int FOREIGN KEY REFERENCES Customers(Id) not null,
CarId int FOREIGN KEY REFERENCES Cars(Id)not null,
TankLevel int,
KilometrageStart int,
KilometrageEnd int,
TotalKilometrage int,
StartDate date,
EndDate date,
TotalDays int,
RateApplied varchar(20),
TaxRate money,
OrderStatus varchar(20),
Notes text
)

INSERT INTO Categories
VALUES (1,'Normal',1,2,3,2),(2,'Cheap',0.5,1,1.5,1),(3,'Lux',2,3,4,2)

INSERT INTO Cars(Id,PlateNumber,CategoryId)
VALUES (1,'B3333',3),(2,'F2323',2),(3,'R5657',1)


INSERT INTO Employees(Id,FirstName,LastName)
VALUES (1,'IVAN','IVANOV'),(2,'STOYAN','STOYANOV'),(3,'BABA','YAGA')

INSERT INTO Customers(Id,DriverLicenceNumber)
VALUES (1,'F56756'),(2,'R4567'),(3,'TY567')

INSERT INTO RentalOrders(Id,EmployeeId,CustomerId,CarId)
VALUES (1,1,1,1),(2,2,2,2),(3,3,3,3)