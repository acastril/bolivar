#!/usr/bin/env bash

# db-maintype2did.sh - update records some more

# Eric
# June 5, 2019 - first cut


# configure
DB='./etc/bolivar.db'
MAINTYPE2DID='./etc/maintype2did.sql'
SQL='./tmp/commands.sql'

# enhance our SQL
echo "BEGIN TRANSACTION;" > $SQL
cat $MAINTYPE2DID         >> $SQL
echo "END TRANSACTION;"   >> $SQL

# do the work and done
cat $SQL | sqlite3 $DB
exit
