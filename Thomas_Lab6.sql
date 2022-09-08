USE [21WQ_BUAN4210_Lloyd_CapeCodd];

/*

SQL Lab #6

Brian Thomas

*/

-- 1
-- The returns all the inventory and order items data back side by side by using an implicit join. 
SELECT *
FROM INVENTORY AS INV, ORDER_ITEM AS OI
WHERE INV.SKU = OI.SKU;

-- 2
-- This returns the total quantity ordered by each store as well as the store's number. Total quantity is renamed 'StoreQuantity'
SELECT StoreNumber, SUM(Quantity) AS 'Store Quantity'
FROM RETAIL_ORDER AS RO, ORDER_ITEM AS OI
WHERE RO.OrderNumber = OI.OrderNumber
GROUP BY StoreNumber
ORDER BY StoreNumber;

-- 4
-- This returns the inventory and order items data back side by side but with an explicit join.
-- I added the ORDER BY so that the table looks nicer.
SELECT *
FROM INVENTORY AS INV
	JOIN ORDER_ITEM AS OI
	ON INV.SKU = OI.SKU
ORDER BY INV.SKU, OI.SKU;

-- 5
-- This returns the WarehouseIDs, Warehousecities, and the SKU_descriptions by using a LEFT OUTER JOIN.
-- And to neaten things up I ordered it by WarehouseID and SKU_description.
SELECT WH.WarehouseID, WarehouseCity, SKU_Description
FROM WAREHOUSE AS WH
	LEFT OUTER JOIN INVENTORY AS INV
	ON WH.WarehouseID = INV.WarehouseID
ORDER BY INV.WarehouseID, SKU_Description;
--		The reason San Francisco has a NULL on SKU_Description is because when LEFT OUTER JOIN is used, SQL tries to match the
-- left data table which is Warehouse to Inventory. When that happens it achieves a NULL because as data set WAREHOUSE may
-- have a WarehouseID label of 500 in the data table, Inventory's table does not. Showing NULL when Left Outer Join was used.
--		The difference between INNER, LEFT, and RIGHT joins are the way that match data records between the two data tables. Inner
-- only shows the data records that are matching between the two data sets. LEFT OUTER takes the entire left table's records and
-- only the matching records in the right table, hence the WarehouseID 500 from WAREHOUSE appearing as NULL in the INVENTORY's
-- SKU_Description. RIGHT OUTER is the opposite, it takes the entire right table's records and only the matching records from
-- the left table.
