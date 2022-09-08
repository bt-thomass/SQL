USE [21WQ_BUAN4210_Lloyd_ExcelsiorMobile]

/*
Project 1: Excelsior Mobile Report
Brian Thomas
*/

-- REPORT QUESTIONS WITH VISUALIZATION
-- 1 --
-- These queries return some summary data so that we can get an idea of what data we'll be working with.
-- A
SELECT CONCAT (FirstName, ' ', LastName) AS 'Full Name', Minutes, DataInMB, Texts, Total
FROM Subscriber AS Sub, Bill AS Bl, LastMonthUsage AS LMU
WHERE Sub.MIN = Bl.MIN AND Bl.MIN = LMU.MIN AND Sub.MIN = LMU.MIN
ORDER BY CONCAT (FirstName,' ', LastName);

-- B
SELECT City, AVG(Minutes) AS Mins, AVG(DataInMB) AS DataMB, AVG(Texts) AS Txt, AVG(Total) AS Ttl
FROM Subscriber AS Sub, Bill AS Bl, LastMonthUsage AS LMU
WHERE Sub.MIN = Bl.MIN AND Bl.MIN = LMU.MIN AND Sub.MIN = LMU.MIN
GROUP BY City
ORDER BY City;

-- C
SELECT City, SUM(Minutes) AS Mins, SUM(DataInMB) AS DataMB, SUM(Texts) AS Txt, SUM(Total) AS Ttl
FROM Subscriber AS Sub, Bill AS Bl, LastMonthUsage AS LMU
WHERE Sub.MIN = Bl.MIN AND Bl.MIN = LMU.MIN AND Sub.MIN = LMU.MIN
GROUP BY City
ORDER BY City;

-- D
SELECT PlanName, AVG(Minutes) AS Mins, AVG(DataInMB) AS DataMB, AVG(Texts) AS Txt, AVG(Total) AS Ttl
FROM Subscriber AS Sub, Bill AS Bl, LastMonthUsage AS LMU
WHERE Sub.MIN = Bl.MIN AND Bl.MIN = LMU.MIN AND Sub.MIN = LMU.MIN
GROUP BY PlanName
ORDER BY PlanName;

-- E
SELECT PlanName, SUM(Minutes) AS Mins, SUM(DataInMB) AS DataMB, SUM(Texts) AS Txt, SUM(Total) AS Ttl
FROM Subscriber AS Sub, Bill AS Bl, LastMonthUsage AS LMU
WHERE Sub.MIN = Bl.MIN AND Bl.MIN = LMU.MIN AND Sub.MIN = LMU.MIN
GROUP BY PlanName
ORDER BY PlanName;

-- REPORT QUESTIONS WITHOUT VISUALIZATION
-- 1 --
-- To help with the marketing team, these queries will show data of our Cities and its customer base along with the plans they use
-- A
SELECT TOP 2 City, COUNT(MIN) AS 'Subscribers'
FROM Subscriber
GROUP BY City
ORDER BY COUNT(MIN) DESC;

-- B
SELECT TOP 3 CITY, COUNT(MIN) AS 'Subscribers'
FROM Subscriber
GROUP BY City
ORDER BY COUNT(MIN);

-- C
-- Instead of giving a specific number of plannames, the marketing team just wants to know which Plans need focus on the marketing aspect,
-- to help with that, I have given an order PlanNames ordering from the least subscribers to the most subscribers.
SELECT PlanName, COUNT(MIN) AS 'Subscribers'
FROM Subscriber
GROUP BY PlanName
ORDER BY COUNT(MIN);

-- 2 --
-- These queries return data that informs us more about the device information the customers use
-- A
SELECT Type, COUNT(IMEI) AS 'Customers'
FROM Device
GROUP BY Type
ORDER BY COUNT(IMEI) DESC;

-- B
-- From the previous data, we know that Apple is the lesser cell phone type, so we will specify Apple when looking at the type.
SELECT FirstName, LastName, Type
FROM Subscriber AS Sub, DirNums AS DN, Device AS Dev
WHERE Sub.MDN = DN.MDN AND DN.IMEI = Dev.IMEI
	AND Type = 'Apple'
GROUP BY Firstname, LastName, Type
ORDER BY COUNT(DN.IMEI) DESC;

-- C
SELECT CONCAT(FirstName, ' ', LastName) AS Customer, YearReleased
FROM Subscriber AS Sub, DirNUms AS DN, Device AS Dev
WHERE Sub.MDN = DN.MDN AND DN.IMEI = Dev.IMEI
	AND YearReleased < 2018
GROUP BY FirstName, LastName, YearReleased
ORDER BY CONCAT(FirstName, ' ', LastName);

-- 3 --
-- Since we are trying to figure out if our customers are using their plans efficiently or not the team wants us to find a city that has high data usage,
-- which requires the city to be within the top 3 most data usage cities, while also having their customers not using the unlimited plan.
SELECT DISTINCT TOP 1 City, DataInMB
FROM Subscriber AS Sub, LastMonthUsage AS LMU, MPlan AS MP
WHERE Sub.MIN = LMU.MIN AND Sub.PlanName = Sub.PlanName
	AND Data IN
		(SELECT Data
		 FROM MPlan
		 WHERE Data <> 'Unlimited')
	AND CITY IN
		(SELECT TOP 3 City
		 FROM Subscriber AS Sub, LastMonthUsage As LMU
		 WHERE Sub.MIN = LMU.MIN
		 GROUP BY City
		 ORDER BY SUM(DataInMB) DESC)
ORDER BY DataInMB DESC;

-- 4 --
-- This returns the data that the financial department had requested
-- A
SELECT TOP 1 FirstName, LastName, Total
FROM Subscriber AS Sub, Bill As Bl
WHERE Sub.MIN = Bl.MIN
ORDER BY Total DESC;

-- B
SELECT TOP 1 PlanName, SUM(Total) AS 'Revenue'
FROM Subscriber AS Sub, Bill AS Bl
WHERE Sub.MIN = Bl.MIN
GROUP BY PlanName
ORDER BY SUM(Total) DESC;

-- 5 --
-- This returns the data useful for understanding the minutes usage of dataplans as well as the subscribers
-- A
SELECT TOP 1 ZipCode, SUM(Minutes) AS Mins
FROM Subscriber AS Sub, LastMonthUsage AS LMU
WHERE Sub.MIN = LMU.MIN
GROUP BY ZipCode
ORDER BY SUM(Minutes) DESC;

-- B
SELECT City
FROM Subscriber AS Sub, LastMonthUsage AS LMU
WHERE Sub.MIN = LMU.MIN
AND LMU.Minutes < 200
	INTERSECT
		SELECT CITY
        FROM Subscriber AS Sub, LastMonthUsage AS LMU
        WHERE Sub.MIN = LMU.MIN
        AND LMU.Minutes > 700;

