#!/usr/bin/env bash

# make-subset - given a year, fill a directory with files dated with that year; use the subset for analysis

# Eric Lease Morgan <emorgan@nd.edu>
# August 29, 2019 - first cut; just for fun; hack on the value of $SQL

 
# configure
SQL="SELECT filename FROM documents WHERE year IS '##YEAR##';"
DB='./etc/bolivar.db'
FILTERED='./filtered'
SUBSET='./subset'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <year>" >&2
	exit
fi

# get input
YEAR=$1
DIRECTORY=$2

# create subset directory
rm -rf $SUBSET
mkdir -p $SUBSET

# build query
SQL=$( echo $SQL | sed "s/##YEAR##/$YEAR/" )

# search and process each result
echo $SQL | sqlite3 $DB | while read ID; do
	
	# re-initialize and do the work
	FILE="$FILTERED/$ID.txt"
	cp $FILE $SUBSET

# fini
done
exit


