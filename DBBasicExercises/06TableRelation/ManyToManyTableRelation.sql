CREATE TABLE Students
(
	StudentID int not null unique,
	Name nvarchar(30)
)

CREATE TABLE Exams
(
	ExamID int not null unique,
	Name nvarchar(30)
)

CREATE TABLE StudentsExams
(
	StudentID int not null,
	ExamID int not null
)

ALTER TABLE Students
ADD CONSTRAINT PK_StudentID
PRIMARY KEY (StudentID)

ALTER TABLE Exams
ADD CONSTRAINT PK_ExamID
PRIMARY KEY (ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT PK_StudentsExams
PRIMARY KEY (StudentID,ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentsExams_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentsExams_Exams 
FOREIGN KEY (ExamID)
REFERENCES Exams(ExamID)

INSERT INTO Students
VALUES
		(1,'Mila'),
		(2,'Tony'),
		(3,'Ron')

INSERT INTO Exams
VALUES
		(101,'SpringMVC'),
		(102,'Neo4j'),
		(103,'Oracle 11g')
		
INSERT INTO StudentsExams
VALUES
		(1,101),
		(1,102),
		(2,101),
		(3,103),
		(2,102),
		(2,103)

