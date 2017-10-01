SELECT
Nickname,
Email,
Password
FROM Users
JOIN Credentials ON Credentials.Id=Users.CredentialId
WHERE Email LIKE '%co.uk'
ORDER BY Email