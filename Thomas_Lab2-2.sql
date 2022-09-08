/*

SQL LAB #2

Brian Thomas

*/

USE [21WQ_BUAN4210_Lloyd_CapeCodd]

--1
-- This returns the water sports department specific SKU Descriptions from the 2014 Catalog
SELECT *
FROM CATALOG_SKU_2014
WHERE Department = 'Water Sports';

--2
-- This returns the SKU and SKU_Description Data from the 2015 Catalog that is specific to the date 1st of April
SELECT SKU, SKU_Description
FROM CATALOG_SKU_2015
WHERE DateOnWebSite = '01-Apr-2015';

--3
-- This returns the City in which the warehouse has an area of over 150,000 Square Ft
SELECT WarehouseCity
FROM WAREHOUSE
WHERE SquareFeet > 150000;

--4
-- This returns the Data of any inventory with the WarehouseID of 300 but has over a quantity of 300 in stock
SELECT *
FROM INVENTORY
WHERE WarehouseID = 300
AND QuantityOnHand > 300;

--5
-- This returns 2013 catalog data that has a catalog page more than 30 or NULL by department order
SELECT *
FROM CATALOG_SKU_2013
WHERE CatalogPage > 30 OR CatalogPage IS NULL
ORDER BY Department;

--6
-- This returns data of Item Orders with the quantity of 1 but are not the price of 300
SELECT *
FROM ORDER_ITEM
WHERE Quantity = 1
AND Price <> 300;

--7
-- This returns all details of any inventory that we have less than 200 in stock and are not ordering any at all currently
SELECT *
FROM INVENTORY
WHERE QuantityOnHand < 200
AND QuantityOnOrder = 0;

--8
-- This returns all details of warehouses that are not in Atlanta, Chicago, or Seattle
SELECT *
FROM WAREHOUSE
WHERE WarehouseCity NOT IN ('Atlanta', 'Chicago', 'Seattle');

--9
-- This returns all data in the 2013 Catalog in order of Catalog Page where the the value is between 20 and 45
SELECT *
FROM CATALOG_SKU_2013
WHERE CatalogPage BETWEEN 20 AND 45
ORDER BY CatalogPage;

--10
-- This returns the SKU and the description of any 2014 Catalog data that has no Catalog Page data
SELECT SKU, SKU_Description
FROM CATALOG_SKU_2014
WHERE CatalogPage IS NULL;