/*

SQL LAB #3

Brian Thomas

*/

--1
-- This returns every detail of inventory related to Scuba
SELECT *
FROM INVENTORY
WHERE SKU_Description LIKE '%scuba%';

--2
-- This returns the SKU and Order Number of the items ordered where the SKU starts with a 10
SELECT SKU, OrderNumber
FROM ORDER_ITEM
WHERE SKU LIKE '10%';

--3
-- This returns all the data from warehouses in which their cities have either an O or an E at the end of the name
SELECT *
FROM WAREHOUSE
WHERE WarehouseCity LIKE '%[OE]';

--4
-- This returns SKU descriptions of departments other than camping from the 2015 catalog
-- The SKU Description's column has been renamed to Item
SELECT SKU_Description AS Item
FROM CATALOG_SKU_2015
WHERE Department <> 'Camping';

--5
-- This returns the SKU, QuantityOnHand and QuantityOnOrder from Inventory where the SKUs have a 12 anywhere in its value.
-- QuantityOnHand is renamed as InStock and QuantityOnOrder is renamed as ForthComing
SELECT SKU, QuantityOnHand AS InStock, QuantityOnOrder AS ForthComing
FROM INVENTORY
WHERE SKU LIKE '%12%';

--6
-- This returns grouped SKU_Descriptions within the Inventory
SELECT SKU_Description
FROM INVENTORY
GROUP BY SKU_Description;

--7
-- This returns the grouped up OrderMonth and OrderYear from the Retail Order
-- Ordermonth has been renamed Month, and Orderyear has been renamed Year
SELECT OrderMonth AS Month, OrderYear AS Year
FROM RETAIL_ORDER
GROUP BY OrderMonth, OrderYear;

--8
-- This returns the grouped up Department and DateOnWebsite from the 2014 catalog where DateOnWebsite has been renamed Pubdate
SELECT Department, DateOnWebSite AS PubDate
FROM CATALOG_SKU_2014
GROUP BY Department, DateOnWebSite;

--9
-- This returns the OrderNumber and the SKU Count grouped under OrderNumber from Order_Item where SKU has been renamed to
-- NumberOfSingleItems
SELECT OrderNumber, COUNT(SKU) AS NumberOfSingleItems
FROM ORDER_ITEM
GROUP BY OrderNumber
HAVING COUNT(SKU) > 1;

--10
-- This returns the order number the sum of extended price and SKU from Order_Item grouped by OrderNumber.
-- Extended Price has been totalled and renamed as TotalCost, while SKU has been assured of more than 1 count
-- and has been renamed as Quantity for clearness sake.
SELECT OrderNumber, SUM(ExtendedPrice) AS TotalCost, COUNT(SKU) as Quantity
FROM ORDER_ITEM
GROUP BY OrderNumber
HAVING COUNT(SKU) > 1;
