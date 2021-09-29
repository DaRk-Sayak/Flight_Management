CREATE DATABASE `flight_management_db`;

USE `flight_management_db`;

CREATE TABLE `flight_management_db`.`roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`role_id`));
  
CREATE TABLE `flight_management_db`.`blocked_tokens` (
  `token_id` INT NOT NULL AUTO_INCREMENT,
  `token` LONGTEXT NOT NULL,
  PRIMARY KEY (`token_id`));
  
CREATE TABLE `flight_management_db`.`meals` (
  `meal_id` INT NOT NULL AUTO_INCREMENT,
  `meal_type` VARCHAR(20) NOT NULL,
  `meal_description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`meal_id`));
  
CREATE TABLE `flight_management_db`.`operating_cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_code` VARCHAR(10) NOT NULL,
  `city_name` VARCHAR(100) NOT NULL,
  `active` BOOLEAN NOT NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `unique_city_code` (`city_code` ASC));
  
CREATE TABLE `flight_management_db`.`files` (
  `file_id` INT NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(100) NOT NULL,
  `file_type` VARCHAR(10) NOT NULL,
  `file_content` BLOB NOT NULL,
  PRIMARY KEY (`file_id`));

CREATE TABLE `flight_management_db`.`roaster_status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`status_id`));
  
CREATE TABLE `flight_management_db`.`coupons` (
  `coupon_id` INT NOT NULL AUTO_INCREMENT,
  `coupon_name` VARCHAR(20) NOT NULL,
  `discount_coupon` TINYINT NOT NULL,
  `coupon_description` VARCHAR(100) NULL,
  `coupon_discount_percentage` INT NULL,
  `active` TINYINT NOT NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`coupon_id`));
 
CREATE TABLE `flight_management_db`.`user_credentials` (
  `credentials_id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`credentials_id`));
  
CREATE TABLE `flight_management_db`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email_verified` TINYINT NOT NULL,
  `role` INT NOT NULL,
  `credentials` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_users_roles` (`role` ASC),
  INDEX `fk_users_credentials` (`credentials` ASC),
  CONSTRAINT `fk_users_roles`
    FOREIGN KEY (`role`)
    REFERENCES `flight_management_db`.`roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_credentials`
    FOREIGN KEY (`credentials`)
    REFERENCES `flight_management_db`.`user_credentials` (`credentials_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `flight_management_db`.`airlines` (
  `airline_id` INT NOT NULL AUTO_INCREMENT,
  `airline_name` VARCHAR(100) NOT NULL,
  `airline_logo` INT NOT NULL,
  `airline_contact_number` VARCHAR(20) NOT NULL,
  `airline_address` VARCHAR(500) NOT NULL,
  `active` TINYINT NOT NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`airline_id`),
  UNIQUE INDEX `unique_airline_name` (`airline_name` ASC),
  INDEX `fk_airlines_logo_files` (`airline_logo` ASC),
  CONSTRAINT `fk_airlines_logo_files`
    FOREIGN KEY (`airline_logo`)
    REFERENCES `flight_management_db`.`files` (`file_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `flight_management_db`.`flights` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `airline` INT NOT NULL,
  `flight_number` VARCHAR(20) NOT NULL,
  `from_city` INT NOT NULL,
  `to_city` INT NOT NULL,
  `start_time` VARCHAR(10) NOT NULL,
  `end_time` VARCHAR(10) NOT NULL,
  `duration` VARCHAR(10) NOT NULL,
  `on_sunday` TINYINT NOT NULL,
  `on_monday` TINYINT NOT NULL,
  `on_tuesday` TINYINT NOT NULL,
  `on_wednesday` TINYINT NOT NULL,
  `on_thursday` TINYINT NOT NULL,
  `on_friday` TINYINT NOT NULL,
  `on_saturday` TINYINT NOT NULL,
  `instrument` VARCHAR(20) NOT NULL,
  `business_class_seats` INT NOT NULL,
  `non_business_class_seats` INT NOT NULL,
  `business_class_seats_price` INT NOT NULL,
  `non_business_class_seat_price` INT NOT NULL,
  `row_count` INT NOT NULL,
  `column_count` INT NOT NULL,
  `meal` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`flight_id`),
  UNIQUE INDEX `unique_flight_number` (`flight_number` ASC),
  INDEX `fk_flight_airlines` (`airline` ASC),
  INDEX `fk_from_operating_citis` (`from_city` ASC),
  INDEX `fk_to_operating_citis` (`to_city` ASC),
  INDEX `fk_flight_meals` (`meal` ASC),
  CONSTRAINT `fk_flight_airlines`
    FOREIGN KEY (`airline`)
    REFERENCES `flight_management_db`.`airlines` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_from_operating_citis`
    FOREIGN KEY (`from_city`)
    REFERENCES `flight_management_db`.`operating_cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_operating_citis`
    FOREIGN KEY (`to_city`)
    REFERENCES `flight_management_db`.`operating_cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_meals`
    FOREIGN KEY (`meal`)
    REFERENCES `flight_management_db`.`meals` (`meal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `flight_management_db`.`roaster` (
  `roaster_id` INT NOT NULL AUTO_INCREMENT,
  `flight` INT NOT NULL,
  `roaster_date` DATETIME NOT NULL,
  `depurture` VARCHAR(10) NOT NULL,
  `arrival` VARCHAR(10) NOT NULL,
  `from_city` INT NOT NULL,
  `to_city` INT NOT NULL,
  `status` INT NOT NULL,
  `delay_time_in_mins` INT NULL,
  `business_class_seats_available` INT NOT NULL,
  `non_business_class_seats_available` INT NOT NULL,
  `business_class_seat_price` INT NOT NULL,
  `non_business_class_seat_price` INT NOT NULL,
  `remarks` VARCHAR(200) NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`roaster_id`),
  INDEX `fk_roaster_flights` (`flight` ASC),
  INDEX `fk_from_operating_cities` (`from_city` ASC),
  INDEX `fk_to_operating_cities` (`to_city` ASC),
  INDEX `fk_roaster_status` (`status` ASC),
  CONSTRAINT `fk_roaster_flights`
    FOREIGN KEY (`flight`)
    REFERENCES `flight_management_db`.`flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_from_operating_cities`
    FOREIGN KEY (`from_city`)
    REFERENCES `flight_management_db`.`operating_cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_operating_cities`
    FOREIGN KEY (`to_city`)
    REFERENCES `flight_management_db`.`operating_cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roaster_status`
    FOREIGN KEY (`status`)
    REFERENCES `flight_management_db`.`roaster_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `flight_management_db`.`pnrs` (
  `pnr_id` INT NOT NULL AUTO_INCREMENT,
  `pnr_number` VARCHAR(10) NOT NULL,
  `user` INT NOT NULL,
  `total_pnr_price` INT NOT NULL,
  `updated_by` VARCHAR(100) NOT NULL,
  `updated_on` DATETIME NOT NULL,
  PRIMARY KEY (`pnr_id`),
  INDEX `fk_pnr_user_idx` (`user` ASC),
  UNIQUE INDEX `unique_pnr_number` (`pnr_number` ASC),
  CONSTRAINT `fk_pnr_user`
    FOREIGN KEY (`user`)
    REFERENCES `flight_management_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE TABLE `flight_management_db`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `pnr` INT NOT NULL,
  `user` INT NOT NULL,
  `roaster` INT NOT NULL,
  `number_of_passengers` INT NOT NULL,
  `price` INT NOT NULL,
  `applied_coupon` INT NULL,
  `confirmed` TINYINT NOT NULL,
  `active` TINYINT NOT NULL,
  `refund_amount` INT NULL,
  `refund_date` DATETIME NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_booking_pnr` (`pnr` ASC),
  INDEX `fk_booking_user` (`user` ASC),
  INDEX `fk_booking_coupon` (`applied_coupon` ASC),
  INDEX `fk_booking_roaster` (`roaster` ASC),
  CONSTRAINT `fk_booking_pnr`
    FOREIGN KEY (`pnr`)
    REFERENCES `flight_management_db`.`pnrs` (`pnr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_user`
    FOREIGN KEY (`user`)
    REFERENCES `flight_management_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_coupon`
    FOREIGN KEY (`applied_coupon`)
    REFERENCES `flight_management_db`.`coupons` (`coupon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_roaster`
    FOREIGN KEY (`roaster`)
    REFERENCES `flight_management_db`.`roaster` (`roaster_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `flight_management_db`.`tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `ticket_number` VARCHAR(20) NOT NULL,
  `booking` INT NOT NULL,
  `passenger_name` VARCHAR(100) NOT NULL,
  `passenger_age` INT NOT NULL,
  `passenger_contact` VARCHAR(20) NOT NULL,
  `passenger_identity_number` VARCHAR(50) NOT NULL,
  `passenger_identity_type` VARCHAR(20) NOT NULL,
  `seat_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_bookings_ticket` (`booking` ASC),
  UNIQUE INDEX `unique_ticket_number` (`ticket_number` ASC),
  CONSTRAINT `fk_bookings_ticket`
    FOREIGN KEY (`booking`)
    REFERENCES `flight_management_db`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `flight_management_db`.`roles` (`role_name`) VALUES ('USER');
INSERT INTO `flight_management_db`.`roles` (`role_name`) VALUES ('ADMIN');

INSERT INTO `flight_management_db`.`user_credentials` (`password`) VALUES ('admin');
INSERT INTO `flight_management_db`.`user_credentials` (`password`) VALUES ('user');

INSERT INTO `flight_management_db`.`users` (`user_name`, `email`, `phone`, `email_verified`, `role`, `credentials`) VALUES ('Admin Name', 'admin@flight.com', '0000000000', true, '2', '1');
INSERT INTO `flight_management_db`.`users` (`user_name`, `email`, `phone`, `email_verified`, `role`, `credentials`) VALUES ('User Name', 'user@flight.com', '0000000000', true, '1', '2');

INSERT INTO `flight_management_db`.`meals` (`meal_type`, `meal_description`) VALUES ('NO MEAL', 'Meals will not be served');
INSERT INTO `flight_management_db`.`meals` (`meal_type`, `meal_description`) VALUES ('VEG MEAL', 'Veg meal will be searved');
INSERT INTO `flight_management_db`.`meals` (`meal_type`, `meal_description`) VALUES ('NON-VEG MEAL', 'Non veg items will be served');

INSERT INTO `flight_management_db`.`roaster_status` (`status_name`) VALUES ('ACTIVE');
INSERT INTO `flight_management_db`.`roaster_status` (`status_name`) VALUES ('CANCELLED');
INSERT INTO `flight_management_db`.`roaster_status` (`status_name`) VALUES ('DELAYED');
INSERT INTO `flight_management_db`.`roaster_status` (`status_name`) VALUES ('RESHEDULED');
INSERT INTO `flight_management_db`.`roaster_status` (`status_name`) VALUES ('COMPLETED');




