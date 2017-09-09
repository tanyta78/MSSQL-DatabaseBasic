CREATE TABLE Persons
(
	PersonID int not null ,
	FirstName nvarchar(30),
	Salary decimal(8,2),
	PassportID int not null,
	CONSTRAINT PK_PersonID PRIMARY KEY(PersonID)
)

CREATE TABLE Passports
(
	PassportID int not null,
	PassportNumber NVARCHAR(30) UNIQUE,
	CONSTRAINT PK_PassportID PRIMARY KEY (PassportID) 
)

ALTER TABLE Persons
ADD CONSTRAINT FK_PassportID FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID)

INSERT INTO Passports
VALUES	(101,'N34FG21B'),
		(102,'K65LO4R7'),
		(103,'ZE657QP2')

INSERT INTO Persons
VALUES	(1,'Roberto',43300.00,102),
		(2,'Tom',56100.00,103),
		(3,'Yana',60200.00,101)



