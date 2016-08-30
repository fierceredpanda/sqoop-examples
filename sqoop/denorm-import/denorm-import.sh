#!/usr/bin/env bash

sqoop import \
    --connect "jdbc:mysql://10.0.2.2:3306/denorm" \
    --username sqoop \
    --password dude001 \
    --query 'SELECT customer.id AS customer_id, customer.first_name, customer.last_name, customer.age, customer.height_inches, customer.weight, address.id AS address_id, address.street_address_1, address.street_address_2, address.city, address.state, address.zip FROM denorm.customer JOIN denorm.address ON (customer.id = address.customer_id) WHERE $CONDITIONS' \
    --target-dir "/user/cloudera/denorm/" \
    --append \
    --as-avrodatafile \
    --m 1