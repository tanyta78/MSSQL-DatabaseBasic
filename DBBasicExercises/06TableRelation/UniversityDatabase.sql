CREATE TABLE Majors
(
MajorID int not null,
Name varchar(50),
CONSTRAINT PK_MajorID PRIMARY KEY (MajorID)
)

CREATE TABLE Payments
(
PaymentID int not null,
PaymentDate date,
PaymentAmount decimal(8,2),
StudentID int,
CONSTRAINT PK_PaymentID PRIMARY KEY (PaymentID)
)

CREATE TABLE Students
(
StudentID int not null,
StudentNumber varchar(10),
StudentName varchar(50),
MajorID int,
CONSTRAINT PK_StudentID PRIMARY KEY (StudentID)
)

CREATE TABLE Agenda
(
StudentID int not null,
SubjectID int not null,
CONSTRAINT PK_StudentID_SubjectID PRIMARY KEY (StudentID,SubjectID)
)

CREATE TABLE Subjects
(
SubjectID int not null,
SubjectName varchar(50),
CONSTRAINT PK_SubjectID PRIMARY KEY (SubjectID)
)

ALTER TABLE Payments
ADD CONSTRAINT FK_Payment_StudentID 
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE Students
ADD CONSTRAINT FK_MajorID 
FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID)

ALTER TABLE Agenda
ADD CONSTRAINT FK_Agenda_StudentID
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE Agenda
ADD CONSTRAINT FK_SubjectID
FOREIGN KEY (SubjectID)
REFERENCES Subjects(SubjectID)