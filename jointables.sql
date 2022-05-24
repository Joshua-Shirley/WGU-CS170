-- -------------------------------------------
-- SFW with 3 joined tables
-- SHOP MENUS
-- ------------------------------------------- 

SELECT 
	-- coffee_id,
	-- coffee.shop_id,
    coffee_shop.shop_name AS Shop,    
    supplier.company_name AS Beans,
    coffee_name AS Roast,
    price_per_pound AS Price
FROM coffee
LEFT JOIN supplier
ON coffee.supplier_id = supplier.supplier_id
LEFT JOIN coffee_shop
ON coffee.shop_id = coffee_shop.shop_id
ORDER BY shop_name ASC, Beans ASC, Roast ASC;
