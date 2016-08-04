#!/usr/bin/env bash

sqoop import \
    --connect "jdbc:mysql://10.0.2.2:3306/simple_pull" \
    --username sqoop \
    --password dude001 \
    --table customer \
    --target-dir "/user/cloudera/simple-pull/" \
    --m 1
