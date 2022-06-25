-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Blue_Bikes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Blue_Bikes` ;

-- -----------------------------------------------------
-- Schema Blue_Bikes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Blue_Bikes` DEFAULT CHARACTER SET utf8 ;
USE `Blue_Bikes` ;

-- -----------------------------------------------------
-- Table `Blue_Bikes`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blue_Bikes`.`users` ;

CREATE TABLE IF NOT EXISTS `Blue_Bikes`.`users` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `usertype` ENUM("Customer", "Subscriber") NOT NULL,
  PRIMARY KEY (`userid`));


-- -----------------------------------------------------
-- Table `Blue_Bikes`.`district`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blue_Bikes`.`district` ;

CREATE TABLE IF NOT EXISTS `Blue_Bikes`.`district` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `Blue_Bikes`.`stations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blue_Bikes`.`stations` ;

CREATE TABLE IF NOT EXISTS `Blue_Bikes`.`stations` (
  `station_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `lat` DOUBLE NOT NULL,
  `long` DOUBLE NOT NULL,
  `docks` INT NOT NULL,
  `year` INT NOT NULL,
  `district_id` INT NOT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `station_dist_idx` (`district_id` ASC) VISIBLE,
  CONSTRAINT `station_dist`
    FOREIGN KEY (`district_id`)
    REFERENCES `Blue_Bikes`.`district` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Blue_Bikes`.`rides`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Blue_Bikes`.`rides` ;

CREATE TABLE IF NOT EXISTS `Blue_Bikes`.`rides` (
  `ride_id` INT NOT NULL AUTO_INCREMENT,
    `trip_duration_sec` INT NOT NULL,
  `trip_duration_min` INT NOT NULL,
  `trip_duration_hour` INT NOT NULL,
  `start_timestamp` TIMESTAMP NOT NULL,
  `stop_timestamp` TIMESTAMP NOT NULL,
  `start_station_id` INT NOT NULL,
  `stop_station_id` INT NOT NULL,
  `usertype_id` INT NOT NULL,
  `bike_id` INT NOT NULL,
  `birth_year` INT NOT NULL,
  `gender` ENUM("Female", "Male", "Unknown", "Not Provided") NOT NULL,
  PRIMARY KEY (`ride_id`),
  INDEX `rider_user_idx` (`usertype_id` ASC) VISIBLE,
  INDEX `start_station_idx` (`start_station_id` ASC) VISIBLE,
  CONSTRAINT `rider_user`
    FOREIGN KEY (`usertype_id`)
    REFERENCES `Blue_Bikes`.`users` (`userid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `start_station`
    FOREIGN KEY (`start_station_id`)
    REFERENCES `Blue_Bikes`.`stations` (`station_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
