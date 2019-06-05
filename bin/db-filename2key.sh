#!/usr/bin/env bash

# db-filename2key.sh - add records to the database

# Eric
# June 5, 2019 - first cut


# configure
DB='./etc/bolivar.db'
FILENAME2KEY='./etc/filename2key.sql'
SQL='./tmp/commands.sql'

# enhance our SQL
echo "BEGIN TRANSACTION;" > $SQL
cat $FILENAME2KEY         >> $SQL
echo "END TRANSACTION;"   >> $SQL

# do the work and done
cat $SQL | sqlite3 $DB
exit
