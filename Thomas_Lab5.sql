/*

SQL Lab #5

Brian Thomas

*/

USE [21WQ_BUAN4210_Lloyd_CapeCodd];

-- 1
-- This returns total quantity ordered of the "Diver Mask Small Clear" item as 'AmtItems'
SELECT SUM(Quantity) AS 'AmtItems'
FROM ORDER_ITEM
WHERE SKU IN
	(SELECT SKU
	 FROM SKU_DATA
	 WHERE SKU_Description = 'Dive Mask, Small Clear');

-- 2
-- This returns the unique warehouse IDs that are associated with the items listed in the 
-- 2014 catalog between catalog pages 24 and 70. Renamed as 'MidBookWarehouseIDs'.
SELECT DISTINCT WarehouseID AS 'MidBookWarehouseIDs'
FROM INVENTORY
WHERE SKU IN
	(SELECT SKU
	 FROM CATALOG_SKU_2014
	 WHERE CatalogPage BETWEEN 24 AND 70);

-- 3
-- This returns the manager, the city, and the state, of the Warehouse that issues the Camping Department items in that order.
SELECT Manager, WarehouseCity, WarehouseState
FROM WAREHOUSE
WHERE WarehouseID IN
	(SELECT WarehouseID
	 FROM INVENTORY
	 WHERE SKU IN
		(SELECT SKU
		 FROM SKU_DATA
		 WHERE Department = 'Camping'))
ORDER BY Manager, WarehouseCity, WarehouseState;

-- 4
-- This returns the Buyer name as well their QuantityOnOrder. Ordered by Buyer name.
SELECT Buyer, 
	(SELECT SUM(QuantityOnOrder)
	 FROM INVENTORY
	 WHERE INVENTORY.SKU = SKU_DATA.SKU) AS QuantityOnOrder
FROM SKU_DATA
ORDER BY Buyer