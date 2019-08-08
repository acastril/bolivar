#!/usr/bin/env bash

# db-insertdates.sh - update records to the database

# Alejandro and Eric
# August 8, 2019 - first cut


# configure
DB='./etc/bolivar.db'
DATES='./etc/dates.sql'
SQL='./tmp/commands.sql'

# enhance our SQL
echo "BEGIN TRANSACTION;" > $SQL
cat $DATES                >> $SQL
echo "END TRANSACTION;"   >> $SQL

# do the work and done
cat $SQL | sqlite3 $DB
exit
