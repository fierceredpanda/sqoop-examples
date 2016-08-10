CREATE SCHEMA IF NOT EXISTS simple_export;

CREATE TABLE IF NOT EXISTS simple_export.customer_export (
  id INT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  street_address_1 VARCHAR(45) NULL,
  street_address_2 VARCHAR(45) NULL,
  city VARCHAR(45) NULL,
  state VARCHAR(2) NULL,
  zip VARCHAR(8) NULL,
  PRIMARY KEY (id));