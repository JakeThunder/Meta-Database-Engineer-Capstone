DROP procedure IF EXISTS `littlelemondb`.`GetMaxQuantity`;
;

DELIMITER $$
USE `littlelemondb`$$
CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(quantity) AS MaxQuantityInOrder
	FROM orders;$$

DELIMITER ;
;