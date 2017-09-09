CREATE TABLE Orders
(
OrderID int not null ,
CustomerID int ,
CONSTRAINT PK_OrderID PRIMARY KEY (OrderID)
)

CREATE TABLE Customers
(
CustomerID int not null,
Name varchar(50),
Birthday date,
CityID int ,
CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
)

CREATE TABLE Cities
(
CityID int not null ,
Name varchar(50),
CONSTRAINT PK_CityID PRIMARY KEY (CityID)
)

ALTER TABLE Orders
ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

ALTER TABLE Customers
ADD CONSTRAINT FK_CityID FOREIGN KEY (CityID) REFERENCES Cities(CityID)

CREATE TABLE OrderItems
(
OrderID int NOT NULL,
ItemID int NOT NULL,
CONSTRAINT PK_Orders_Items PRIMARY KEY (OrderID,ItemID)
)

CREATE TABLE Items
(
ItemID int not null,
Name varchar(50),
ItemTypeID int,
CONSTRAINT PK_ItemID PRIMARY KEY (ItemID)
)

CREATE TABLE ItemTypes
(
ItemTypeID int not null,
Name varchar(50),
CONSTRAINT PK_ItemTypeID PRIMARY KEY (ItemTypeID),
)

ALTER TABLE Items
ADD CONSTRAINT FK_ItemTypeID FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)


ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderID 
FOREIGN KEY (OrderID) 
REFERENCES Orders(OrderID)

ALTER TABLE OrderItems
ADD CONSTRAINT FK_ItemID 
FOREIGN KEY (ItemID) 
REFERENCES Items(ItemID)