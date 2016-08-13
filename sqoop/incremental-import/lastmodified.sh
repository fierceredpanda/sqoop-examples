#!/usr/bin/env bash

sqoop job --create lastmodified-job \
    -- import \
    --connect "jdbc:mysql://10.0.2.2:3306/incremental" \
    --username sqoop \
    --table movie_reviews \
    --target-dir "/user/cloudera/incremental/lastmodified/" \
    --incremental lastmodified \
    --check-column modify_date \
    --last-value "2016-08-01 12:00:00" \
    --append \
    --m 1

sqoop job --exec lastmodified-job