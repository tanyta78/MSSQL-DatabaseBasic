CREATE TABLE Manufacturers
(
ManufacturerID int identity(1,1),
Name varchar(30),
EstablishedOn date 
)

CREATE TABLE Models(
ModelID int identity(101,1),
Name varchar(30),
ManufacturerID int not null
)

INSERT INTO Manufacturers
VALUES	('BMV','1916/03/07'),
		('Tesla','2003/01/01'),
		('Lada','1966/05/01')

INSERT INTO Models
VALUES	('X1',1),
		('i6',1),
		('ModelS',2),
		('ModelX',2),
		('Model3',2),
		('Nova',3)

ALTER TABLE Manufacturers
ADD CONSTRAINT PK_Manufacturer 
PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT PK_Model 
PRIMARY KEY (ModelID)

ALTER TABLE Models
ADD CONSTRAINT FK_ManufacturerID 
FOREIGN KEY (ManufacturerID) 
REFERENCES Manufacturers(ManufacturerID)