-- -------------------------------------------
-- SFW SELECT FROM WHERE example
-- -------------------------------------------

SELECT shop_id,
	shop_name,
    city,
    state
FROM coffee_shop
WHERE state in ('NS', 'VC' );
