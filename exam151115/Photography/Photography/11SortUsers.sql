SELECT
Users.Username,
Users.FullName

FROM Users
ORDER BY LEN(CONCAT(Username,FullName)),Users.BirthDate DESC