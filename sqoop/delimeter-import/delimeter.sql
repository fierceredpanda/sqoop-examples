CREATE SCHEMA IF NOT EXISTS delimeter;

CREATE TABLE IF NOT EXISTS delimeter.movie_reviews (
  name VARCHAR(45) NOT NULL,
  rotten_tomatoes INT NOT NULL,
  create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modify_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (name));

INSERT INTO delimeter.movie_reviews (name, rotten_tomatoes, create_date, modify_date) VALUES
    ('Suicide Squad', 26, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Jason Bourne', 57, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Bad Moms', 63, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('The Secret Life of Pets', 73, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Star Trek Beyond', 84, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Nine Lives', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Lights Out', 76, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);