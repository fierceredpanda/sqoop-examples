#!/usr/bin/env bash

sqoop import \
    --connect "jdbc:mysql://10.0.2.2:3306/simple_import" \
    --username sqoop \
    --password dude001 \
    --table customer \
    --target-dir "/user/cloudera/simple-import/" \
    --m 1
