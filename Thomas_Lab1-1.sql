/*

SQL LAB #1

Brian Thomas

*/

USE [21WQ_BUAN4210_Lloyd_CapeCodd]

--1
SELECT *
FROM SKU_DATA;
-- This is a return for all data in SKU_Data

--2
SELECT WarehouseCity, WarehouseState
FROM WAREHOUSE;
-- This is a return to show City and State for each Warehoues in the Data

--3
SELECT SKU, Department, Buyer
FROM SKU_DATA;
-- This is a return for the SKU, Department and Buyer Data from SKU_DATA

--4
SELECT DISTINCT SKU_Description
FROM INVENTORY;
-- This is a return for unique SKU_Descriptions from the Inventory

--5
SELECT DISTINCT Department, SKU_Description
FROM CATALOG_SKU_2013;
-- This is a return for unique Deparments and SKU_Descriptions from the 2013 Catalog

--6
SELECT TOP 10 QuantityOnHand, SKU
FROM INVENTORY;
-- This is a return for the top 10 Quantity on Hand as well as its SKU from the Inventory Table

--7
SELECT *
FROM CATALOG_SKU_2014
ORDER BY CatalogPage;
-- This is a return of the 2014 Catalog Data but ordered by the CatalogID in default ascending order (basic.. order...)

--8
SELECT Price, SKU
FROM ORDER_ITEM
ORDER BY Price ASC;
-- This is a return for the Price and SKU of the Order_Item but in ascending order of Price

--9
SELECT WarehouseCity, Manager, SquareFeet
FROM WAREHOUSE
ORDER BY SquareFeet DESC;
-- This is a return for the Warehouse City, Manager, and Squarefeet of the Warehouse table in descending order by Squarefeet

--10
SELECT QuantityOnHand, QuantityOnOrder, SKU
FROM INVENTORY
ORDER BY QuantityOnHand ASC, QuantityOnOrder DESC;
-- This is a specified order of ascending QuantityOnHand and descending QuantityOnOrder from the Inventory Table
