-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `table_number` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_Bookings_Customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `littlelemondb`.`customers` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `salary` INT NULL DEFAULT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_Staff_Roles1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `littlelemondb`.`roles` (`role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`contactdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`contactdetails` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `staff_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `fk_ContactDetails_Customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_ContactDetails_Staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_ContactDetails_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `littlelemondb`.`customers` (`customer_id`),
  CONSTRAINT `fk_ContactDetails_Staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `littlelemondb`.`staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menuitems` (
  `menu_item_id` INT NOT NULL AUTO_INCREMENT,
  `course` VARCHAR(45) NULL DEFAULT NULL,
  `starter` VARCHAR(45) NULL DEFAULT NULL,
  `desert` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`menu_item_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menus` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cuisine` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menucontent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menucontent` (
  `menu_id` INT NOT NULL,
  `menu_item_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`, `menu_item_id`),
  INDEX `fk_Menus_has_MenuItems_MenuItems1_idx` (`menu_item_id` ASC) VISIBLE,
  INDEX `fk_Menus_has_MenuItems_Menus1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menus_has_MenuItems_MenuItems1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `littlelemondb`.`menuitems` (`menu_item_id`),
  CONSTRAINT `fk_Menus_has_MenuItems_Menus1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `littlelemondb`.`menus` (`menu_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `total_cost` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Orders_Menus1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `littlelemondb`.`customers` (`customer_id`),
  CONSTRAINT `fk_Orders_Menus1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `littlelemondb`.`menus` (`menu_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orderdeliverystatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orderdeliverystatus` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `order_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_OrderDeliveryStatus_Orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_OrderDeliveryStatus_Staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_OrderDeliveryStatus_Orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `littlelemondb`.`orders` (`order_id`),
  CONSTRAINT `fk_OrderDeliveryStatus_Staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `littlelemondb`.`staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
