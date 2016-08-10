#!/usr/bin/env bash

sqoop export \
    --connect "jdbc:mysql://10.0.2.2:3306/simple_export" \
    --username sqoop \
    --password dude001 \
    --table customer_export \
    --export-dir "/user/cloudera/simple-import/" \
    --m 1
