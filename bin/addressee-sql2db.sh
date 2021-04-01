#!/usr/bin/env bash

# addressee-sql2db.sh - given a directory of SQL update statements, update the database

# Eric Lease Morgan <emorgan@nd.edu>
# March 31, 2021 - first cut


# configure
SQL='./tmp/addressees'
TRANSACTION='./tmp/update-transaction.sql'
DB='./etc/bolivar.db'

# create transaction
echo "BEGIN TRANSACTION;" >  $TRANSACTION
cat $SQL/*.sql            >> $TRANSACTION
echo "END TRANSACTION;"   >> $TRANSACTION

# do the work and done
cat $TRANSACTION | sqlite3 $DB
exit
