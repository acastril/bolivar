#!/usr/bin/env bash

# search.pl - given a mode and a query, do a full text search 

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# February 2, 2021; cool!


# configure
DB='./etc/bolivar.db'
TEMPLATE="##MODE##\nSELECT filename, did, day, month, year, addressee, place, type, './filtered/' || filename || '.txt' as txt FROM indx WHERE indx MATCH '##QUERY##' ORDER BY RANK;"

# sanity check
if [[ -z $1 || -z $2 ]]; then
	echo "Usage: $0 <columns|csv|lines|tabs> <query>" >&2
	exit
fi

# get input
MODE=$1
QUERY=$2

# configure mode
if [[ $MODE == 'tabs' ]]; then
	MODE='.mode tabs'
elif [[ $MODE == 'columns' ]]; then
	MODE=".mode columns"
elif [[ $MODE == 'csv' ]]; then
	MODE=".headers on\n.mode csv"
elif [[ $MODE == 'lines' ]]; then
	MODE='.mode lines'
else
	echo "Usage: $0 <columns|csv|lines|tabs> <query>" >&2
	exit
fi

# do the work and done
echo -e $TEMPLATE | sed "s/##MODE##/$MODE/" | sed "s/##QUERY##/$QUERY/" | sqlite3 $DB
exit
