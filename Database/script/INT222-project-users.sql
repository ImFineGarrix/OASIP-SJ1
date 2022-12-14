-- MySQL Script generated by MySQL Workbench
-- Wed Aug 17 17:16:50 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

/*!40101 SET NAMES utf8 */;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oasip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oasip` DEFAULT CHARACTER SET utf8 ;
USE `oasip` ;

-- -----------------------------------------------------
-- Table `oasip`.`eventCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oasip`.`eventCategories` ;

CREATE TABLE IF NOT EXISTS `oasip`.`eventCategories` (
  `eventCategoryId` INT NOT NULL,
  `eventCategoryName` VARCHAR(100) NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventCategoryDescription` VARCHAR(500) NULL,
  UNIQUE INDEX `eventCategoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE,
  PRIMARY KEY (`eventCategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasip`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oasip`.`events` ;

CREATE TABLE IF NOT EXISTS `oasip`.`events` (
  `eventId` INT NOT NULL AUTO_INCREMENT,
  `bookingName` VARCHAR(100) NOT NULL,
  `bookingEmail` VARCHAR(150) NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventNotes` VARCHAR(500) NULL,
  `eventCategoryId` INT NOT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_events_eventCategories_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_events_eventCategories`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `oasip`.`eventCategories` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasip`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oasip`.`users` ;

CREATE TABLE IF NOT EXISTS `oasip`.`users` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(90) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `role` ENUM("student", "admin", "lecturer") NOT NULL,
  `createdOn` DATETIME NOT NULL default now(),
  `updatedOn` DATETIME NOT NULL default now() on update now(),
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- create user 'dev'@'%' identified by 'sj63noodle';
-- grant all privileges on *.* to 'dev'@'%';
-- flush privileges;