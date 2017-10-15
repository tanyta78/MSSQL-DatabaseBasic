--Problem 1.	Records’ Count
SELECT COUNT(Id) AS Count
FROM WizzardDeposits AS WD

--Problem 2.	Longest Magic Wand
SELECT MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits

--Problem 3.	Longest Magic Wand per Deposit Groups
SELECT 
	DISTINCT WD.DepositGroup,
	MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits AS WD
GROUP BY WD.DepositGroup

--Problem 4.	* Smallest Deposit Group per Magic Wand Size
SELECT
	WD.DepositGroup
FROM WizzardDeposits AS WD
GROUP BY WD.DepositGroup
HAVING AVG(WD.MagicWandSize)=(
			SELECT MIN (WandSizeTable.AverageSizes) AS MinimalSize
			FROM (
                    SELECT AVG (w.MagicWandSize) AS AverageSizes
                    FROM WizzardDeposits w
                    GROUP BY w.DepositGroup
				 ) AS WandSizeTable)
--Problem 4.	* Smallest Deposit Group per Magic Wand Size
SELECT TOP 1 WITH TIES DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)


--Problem 5.	Deposits Sum
SELECT
	WD.DepositGroup,
	SUM(WD.DepositAmount) AS [TotalSum]
FROM WizzardDeposits AS WD
GROUP BY WD.DepositGroup

--Problem 6.	Deposits Sum for Ollivander Family
SELECT
	WD.DepositGroup,
	SUM(WD.DepositAmount) AS [TotalSum]
FROM WizzardDeposits AS WD
WHERE WD.MagicWandCreator='Ollivander family'
GROUP BY WD.DepositGroup

--Problem 7.	Deposits Filter
SELECT
	WD.DepositGroup,
	SUM(WD.DepositAmount) AS [TotalSum]
FROM WizzardDeposits AS WD
WHERE WD.MagicWandCreator='Ollivander family'
GROUP BY WD.DepositGroup
HAVING SUM(WD.DepositAmount)<150000
ORDER BY TotalSum DESC

--Problem 8.	 Deposit Charge
SELECT
	WD.DepositGroup,
	WD.MagicWandCreator,
	MIN(WD.DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits AS WD
GROUP BY WD.DepositGroup,WD.MagicWandCreator
ORDER BY MagicWandCreator,DepositGroup

--Problem 9.	Age Groups
SELECT 
	CASE
	  WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN w.Age >= 61 THEN '[61+]'
	END AS [AgeGroup],
COUNT(*) AS [WizardCount]
	FROM WizzardDeposits AS w
GROUP BY CASE
	  WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN w.Age >= 61 THEN '[61+]'
	END

--Problem 9.	Age Groups
SELECT ageGroups.AgeGroup, COUNT(*)AS [WizardCount] FROM
(
SELECT 
	CASE
	  WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN w.Age >= 61 THEN '[61+]'
	END AS [AgeGroup]
	FROM WizzardDeposits AS w
	)AS ageGroups
GROUP BY ageGroups.AgeGroup

--Problem 10.	First Letter
SELECT 
	LEFT(w.FirstName,1) as FirstLetter
FROM WizzardDeposits as w
WHERE w.DepositGroup='Troll Chest'
GROUP BY LEFT(w.FirstName,1)
ORDER BY FirstLetter

--Problem 11.	Average Interest 
SELECT 
	W.DepositGroup,
	W.IsDepositExpired,
	AVG(W.DepositInterest) AS AverageInterest
FROM WizzardDeposits AS W
WHERE W.DepositStartDate>'1985/01/01'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY W.DepositGroup DESC,W.IsDepositExpired 

--Problem 12.	* Rich Wizard, Poor Wizard
--NEXT TIME 
declare @sumDif DECIMAL(18,2)
set @sumDif =  (
    select 
        sum( w.DepositAmount - wi.DepositAmount) 
    from WizzardDeposits w
        join WizzardDeposits wi
        on wi.Id = w.Id + 1)
select @sumDif

--Problem 12.	* Rich Wizard, Poor Wizard!!!!
DECLARE @currentDeposit DECIMAL(8,2)
DECLARE @previousDeposit DECIMAL(8,2)
DECLARE @totalSum DECIMAL(8,2) = 0

DECLARE wizardCursor CURSOR FOR SELECT DepositAmount FROM WizzardDeposits
OPEN wizardCursor
		FETCH NEXT FROM wizardCursor INTO @currentDeposit

		WHILE @@FETCH_STATUS = 0
		BEGIN
		IF(@previousDeposit IS NOT NULL)
			BEGIN
				SET @totalSum += (@previousDeposit-@currentDeposit)
			END
			SET @previousDeposit = @currentDeposit
			FETCH NEXT FROM wizardCursor INTO @currentDeposit
		END

CLOSE wizardCursor
DEALLOCATE wizardCursor

SELECT @totalSum

--Problem 12.	* Rich Wizard, Poor Wizard!!!!
SELECT SUM(wizzardDep.Difference)as Result FROM(
				SELECT
				FirstName,
				DepositAmount,
				LEAD(FirstName) OVER (ORDER BY Id) AS GuestWizzard,
				LEAD(DepositAmount) OVER (ORDER BY Id) AS GuestDepozit,
				DepositAmount-LEAD(DepositAmount) OVER (ORDER BY Id) as Difference
				FROM WizzardDeposits
				) AS wizzardDep
