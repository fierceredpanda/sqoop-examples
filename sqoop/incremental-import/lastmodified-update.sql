UPDATE incremental.movie_reviews SET rotten_tomatoes = 1, modify_date = CURRENT_TIMESTAMP WHERE name = 'Suicide Squad';
UPDATE incremental.movie_reviews SET rotten_tomatoes = 100, modify_date = CURRENT_TIMESTAMP WHERE name = 'Star Trek Beyond';
UPDATE incremental.movie_reviews SET rotten_tomatoes = 95, modify_date = CURRENT_TIMESTAMP WHERE name = 'The Secret Life of Pets';
