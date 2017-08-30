SELECT 
	ProductName,
	OrderDate,
	DATEADD(DAY,3,OrderDate) as [Pay Due],
	DATEADD(MONTH,1,OrderDate) as [Deliver Due]
FROM Orders