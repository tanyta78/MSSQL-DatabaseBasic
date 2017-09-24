CREATE TABLE CustomerReviews(
ReviewID INT NOT NULL,
ReviewContent VARCHAR(255) NOT NULL,
ReviewGrade INT CHECK (ReviewGrade BETWEEN 0 AND 10),
AirlineID INT NOT NULL,
CustomerID INT NOT NULL,
CONSTRAINT PK_CustomerReviews PRIMARY KEY(ReviewID),
CONSTRAINT FK_CustomerReviews_Customers FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
CONSTRAINT FK_CustomerReviews_Airlines FOREIGN KEY(AirlineID) REFERENCES Airlines(AirlineID),
)

CREATE TABLE CustomerBankAccounts(
AccountID INT NOT NULL,
AccountNumber VARCHAR(10) NOT NULL UNIQUE,
Balance DECIMAL(10,2) NOT NULL,
CustomerID INT NOT NULL,
CONSTRAINT PK_CustomerBankAccounts PRIMARY KEY(AccountID),
CONSTRAINT FK_CustomerBankAccounts_Customers FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
)
