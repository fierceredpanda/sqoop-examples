#!/usr/bin/env bash

sqoop import \
    --connect "jdbc:mysql://10.0.2.2:3306/delimeter" \
    --username sqoop \
    --password dude001 \
    --table movie_reviews \
    --target-dir "/user/cloudera/delimeter/" \
    --fields-terminated-by \| \
    --append \
    --m 1
