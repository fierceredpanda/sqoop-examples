CREATE SCHEMA `simple_pull` ;

CREATE TABLE `simple_pull`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `street_address_1` VARCHAR(45) NULL,
  `street_address_2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(2) NULL,
  `zip` VARCHAR(8) NULL,
  PRIMARY KEY (`id`));

INSERT INTO simple_pull.customer (first_name, last_name, street_address_1, street_address_2, city, state, zip)
VALUES
  ('Bob', 'Dylan', '123 W Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Tom', 'Hanks', '234 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Tom', 'Cruise', '345 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Jackie', 'Chan', '456 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Chow Yun', 'Fat', '567 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Sandra', 'Bullock', '678 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
  ('Jessica', 'Chastain', '789 E Hollywood', NULL, 'Hollywood', 'CA', '90028');