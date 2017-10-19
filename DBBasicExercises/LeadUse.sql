--LEAD FOR NEXT

SELECT
FirstName,
DepositAmount,
LEAD(FirstName) OVER (ORDER BY Id) as GuestWizzard,
LEAD(DepositAmount) OVER (ORDER BY Id) as GuestDeposit,
DepositAmount- LEAD(DepositAmount) OVER (ORDER BY Id) as Difference
FROM WizzardDeposits


--LAG  => FOR PREVIOUS

SELECT
FirstName,
DepositAmount,
LAG(FirstName) OVER (ORDER BY Id) as GuestWizzard,
LAG(DepositAmount) OVER (ORDER BY Id) as GuestDeposit,
DepositAmount- LAG(DepositAmount) OVER (ORDER BY Id) as Difference
FROM WizzardDeposits