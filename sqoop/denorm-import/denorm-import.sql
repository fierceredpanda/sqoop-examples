CREATE SCHEMA IF NOT EXISTS denorm;

CREATE TABLE IF NOT EXISTS denorm.customer (
  id INT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  height_inches INT NOT NULL,
  weight INT NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS denorm.address (
  id INT NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  street_address_1 VARCHAR(45) NULL,
  street_address_2 VARCHAR(45) NULL,
  city VARCHAR(45) NULL,
  state VARCHAR(2) NULL,
  zip VARCHAR(8) NULL,
  PRIMARY KEY (id));


INSERT INTO denorm.customer (first_name, last_name, age, height_inches, weight)
VALUES
  (1, 'Bob', 'Dylan', 75, 67, 130),
  (2, 'Tom', 'Hanks', 60, 72, 170),
  (3, 'Tom', 'Cruise', 54, 67, 154),
  (4, 'Jackie', 'Chan', 62, 68, 160),
  (5, 'Chow Yun', 'Fat', 61, 72, 180),
  (6, 'Sandra', 'Bullock', 52, 67, 123),
  (7, 'Jessica', 'Chastain', 39, 64, 108);

  INSERT INTO denorm.address (customer_id, street_address_1, street_address_2, city, state, zip)
  VALUES
    (1, '123 W Hollywood Ave', NULL, 'Hollywood', 'CA', '90028'),
    (1, '235 W California St', NULL, 'Hollywood', 'CA', '90028'),
    (1, '234 E Main St', NULL, 'Hollywood', 'CA', '90028'),
    (2, '345 E Lexington Ave', NULL, 'Hollywood', 'CA', '90028'),
    (5, '456 E Malibu Circle', NULL, 'Miami', 'FL', '90028'),
    (5, '567 S Hong Kong Way', NULL, 'Hong Kong', 'CH', '90028'),
    (6, '678 E Hollywood', NULL, 'Hollywood', 'CA', '90028'),
    (6, '900 W Maricopa', NULL, 'Hollywood', 'CA', '90028'),
    (6, '1500 E Pensylvania Ave', NULL, 'Hollywood', 'CA', '90028'),
    (6, '767 E Germann', NULL, 'Hollywood', 'CA', '90028'),
    (7, '789 E Hollywood', NULL, 'Hollywood', 'CA', '90028');