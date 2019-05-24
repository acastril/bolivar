#!/usr/bin/env bash

# db-initialize.sh - create a database

# Eric
# May 24, 2019 - first cut


# configure
DB='./etc/bolivar.db'
SCHEMA='./etc/schema.sql'

# initialize
rm -rf $DB

# do the work and done
cat $SCHEMA | sqlite3 $DB
exit
