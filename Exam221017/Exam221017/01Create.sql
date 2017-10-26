--DROP Database ReportService

CREATE Database ReportService

CREATE TABLE Users
(Id        INT IDENTITY PRIMARY KEY,
 Username  NVARCHAR(30) NOT NULL UNIQUE,
 Password  NVARCHAR(50) NOT NULL,
 Name      NVARCHAR(50),
 Gender    CHAR(1) CHECK(Gender IN('M', 'F')),
 BirthDate DATETIME,
 Age       INT,
 Email     NVARCHAR(50) NOT NULL
);
CREATE TABLE Departments
(Id   INT IDENTITY PRIMARY KEY,
 Name NVARCHAR(50) NOT NULL
);
CREATE TABLE Employees
(Id           INT IDENTITY PRIMARY KEY,
 FirstName    NVARCHAR(25),
 LastName     NVARCHAR(25),
 Gender       CHAR(1) CHECK(Gender IN('M', 'F')),
 BirthDate    DATETIME,
 Age          INT,
 DepartmentId INT NOT NULL
                  FOREIGN KEY REFERENCES Departments(Id)
);
CREATE TABLE Categories
(Id           INT IDENTITY PRIMARY KEY,
 Name         VARCHAR(50) NOT NULL,
 DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
);
CREATE TABLE Status
(Id    INT IDENTITY PRIMARY KEY,
 Label VARCHAR(30) NOT NULL,
);
CREATE TABLE Reports
(Id          INT IDENTITY PRIMARY KEY,
 CategoryId  INT NOT NULL
                 FOREIGN KEY REFERENCES Categories(Id),
 StatusId    INT NOT NULL
                 FOREIGN KEY REFERENCES Status(Id),
 OpenDate    DATETIME NOT NULL,
 CloseDate   DATETIME,
 Description VARCHAR(200),
 UserId      INT NOT NULL
                 FOREIGN KEY REFERENCES Users(Id),
 EmployeeId  INT FOREIGN KEY REFERENCES Employees(Id)
);
