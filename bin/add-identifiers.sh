#!/usr/bin/env bash

# add-identifiers.sh - given a list of files, update the database with document identifiers

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# April 26, 2021 - first investigations


# configure
TRANSACTION='./tmp/transaction-did.sql'
ADDIDENTIFIERS='./bin/add-identifiers.py'
DB='./etc/bolivar.db'
INITIALIZE="UPDATE documents SET did = '';"
FILTERED='./filtered'

# create a transaction
echo "BEGIN TRANSACTION;"                                >  $TRANSACTION
echo $INITIALIZE                                         >> $TRANSACTION
find $FILTERED -name "*.txt" | parallel $ADDIDENTIFIERS  >> $TRANSACTION
echo "END TRANSACTION;"                                  >> $TRANSACTION

# do the work and done
cat $TRANSACTION | sqlite3 $DB
exit
