--add check constraint in bits--
ALTER TABLE Users
ADD CONSTRAINT CH_PictureSize CHECK (DATALENGTH(ProfilePicture)<900*1024);

--to check constraint--
DECLARE @C VARCHAR(max)='|'
DECLARE @ProfilePicture VARBINARY(MAX)=CONVERT(VARBINARY(MAX),REPLICATE(@C,(921599)));

INSERT INTO Users(Username,Password,ProfilePicture)
values('Test','Test',@ProfilePicture)

--add constraint for unique--
ALTER TABLE Users
/*ALTER COLUMN Username VARCHAR(30) NOT NULL UNIQUE*/
ADD CONSTRAINT UQ_Username UNIQUE(Username);

--add constraint for check gender--
ALTER TABLE People
ADD CONSTRAINT CH_Gender CHECK (Gender='m' OR Gender='f');

--drop constraint--
ALTER TABLE Users
DROP CONSTRAINT UQ_Username


--change primary key--
ALTER TABLE Users
Drop CONSTRAINT [PK__Users__77222459366EA823]

--add compositor - primary key with two values--
ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id,Username)

ALTER TABLE Users
ADD CONSTRAINT CH_PasswordLength CHECK (LEN(Password)>=5)

--set default value--
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users(Username,Password)
VALUES ('tRALALA','EWEWEWE')

ALTER TABLE Users
Drop CONSTRAINT[PK_Users]

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE (Username)

ALTER TABLE Users
ADD CONSTRAINT CH_UsernameLen CHECK (LEN(Username)>=3)
