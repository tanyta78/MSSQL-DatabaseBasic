CREATE DATABASE Bakery
go

CREATE TABLE Countries
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Distributors
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(25) NOT NULL UNIQUE,
	AddressText NVARCHAR(30),
	Summary NVARCHAR(200),
	CountryId INT NOT NULL,
	CONSTRAINT FK_Distributors_Countries FOREIGN KEY(CountryId)
	REFERENCES Countries(Id)
)

CREATE TABLE Customers
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Gender CHAR(1) CHECK (Gender = 'M' OR Gender = 'F'),
	Age INT,
	PhoneNumber CHAR(10),
	CountryId INT,
	CONSTRAINT FK_Customers_Countries FOREIGN KEY(CountryId)
	REFERENCES Countries(Id)
)

CREATE TABLE Products
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(25) UNIQUE,
	Description NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price MONEY CHECK (Price > 0)
)

CREATE TABLE Feedbacks
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Description NVARCHAR(255),
	Rate DECIMAL(10,2),
	ProductId INT,
	CustomerId INT,
	CONSTRAINT FK_Feedbacks_Products FOREIGN KEY(ProductId)
	REFERENCES Products(Id),
	CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY(CustomerId)
	REFERENCES Customers(Id)
)

CREATE TABLE Ingredients
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(30),
	Description NVARCHAR(200),
	OriginCountryId INT,
	DistributorId INT,
	CONSTRAINT FK_Ingredients_Countries FOREIGN KEY(OriginCountryId)
	REFERENCES Countries(Id),
	CONSTRAINT FK_Ingredients_Distributors FOREIGN KEY(DistributorId)
	REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients
(
	ProductId INT NOT NULL,
	IngredientId INT NOT NULL,
	CONSTRAINT PK_ProductsIngredients PRIMARY KEY(ProductId, IngredientId),
	CONSTRAINT FK_ProductsIngredients_Products FOREIGN KEY(ProductId)
	REFERENCES Products(Id),
	CONSTRAINT FK_ProductsIngredients_Ingredients FOREIGN KEY(IngredientId)
	REFERENCES Ingredients(Id)
)