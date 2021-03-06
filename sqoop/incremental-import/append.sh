#!/usr/bin/env bash

sqoop job --create append-job \
    -- import \
    --connect "jdbc:mysql://10.0.2.2:3306/incremental" \
    --username sqoop \
    --table log_records \
    --target-dir "/user/cloudera/incremental/append/" \
    --incremental append \
    --check-column id \
    --last-value 0 \
    --append \
    --m 1

sqoop job --exec append-job