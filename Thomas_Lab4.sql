/*

SQL Lab #4

Brian Thomas

*/

USE [21WQ_BUAN4210_Lloyd_CapeCodd];

-- 1
-- This returns every distinct month that retail orders were made but only the first 3
SELECT DISTINCT LEFT(OrderMonth, 3) as 'OrderMonth'
FROM RETAIL_ORDER;

-- 2
-- This returns all warehousecities where size is greater than 130,000 sqft in upper case. Renamed CapitalCity
SELECT UPPER(WarehouseCity) AS CapitalCity
FROM WAREHOUSE
WHERE SquareFeet > 130000;

-- 3
-- This returns the number of rows in the 2013 catalog that have pagenumbers in them
SELECT COUNT(*) AS RowsInCatalog2013
FROM CATALOG_SKU_2013
WHERE CatalogPage IS NOT NULL;

-- 4
-- This returns the sum of all extended prices from Order Item as Total Price
SELECT SUM(ExtendedPrice) AS TotalPrice
FROM ORDER_ITEM;

-- 5
-- This returns the average of extended price where all prices put in the average is above 100
SELECT AVG(ExtendedPrice) AS AVGPRICE100ABOVE
FROM ORDER_ITEM
WHERE ExtendedPrice > 100;

-- 6
-- This Returns the maximum and the minimum of the prices in our orders renamed MaxPrice and MinPrice
SELECT MAX( ExtendedPrice) AS MaxPrice,
       MIN( ExtendedPrice) AS MinPrice
FROM ORDER_ITEM;

-- 7
-- This returns the WarehouseCity, and State in the format of (City), (State) as Location.
-- This also returns Warehouse ID and is all ordered based on WarehouseID
SELECT WarehouseID, CONCAT(RTRIM(WarehouseCity), ', ' ,WarehouseState) AS 'Location'
FROM WAREHOUSE
ORDER BY WarehouseID;

-- 8
-- This returns a concatinated string in the format of "We have (QuantityOnHand) of the (SKU_Description) in Inventory"
-- of every item in Inventory. Renamed StatementsOfInventory.
SELECT CONCAT('We have ', QuantityOnHand, ' of the ', RTRIM(SKU_DESCRIPTION), ' in Inventory') AS StatementsOfInventory
FROM INVENTORY;

-- 9
-- This returns the current year 2021
SELECT DATEPART(Year, GETDATE()) AS CurrYear;

-- 10
-- This returns the date one month after today
SELECT DATEADD(Month, 1, GETDATE()) AS OneMonthLater;
