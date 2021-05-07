#!/usr/bin/env bash

# index.sh - create a full text index

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# May 7, 2021 - first cut; based in indexing ITAL


# configure
DB='./etc/bolivar.db'
TRANSACTION="./tmp/transaction.sql"
TXT="./filtered"

# configure full text table
DROPFULLTEXT='DROP TABLE IF EXISTS fulltext;'
CREATEFULLTEXT='CREATE TABLE fulltext ( filename TEXT, fulltext TEXT );'
TEMPLATE="INSERT INTO fulltext ( filename, fulltext ) VALUES ( '##ID##', '##FULLTEXT##' );"

# configure index table
DROPINDX='DROP TABLE IF EXISTS indx;'
CREATEINDX='CREATE VIRTUAL TABLE indx USING FTS5( filename, did, day, month, year, addressee, place, type, fulltext );'
INDEX='INSERT INTO indx SELECT d.filename, d.did, d.day, d.month, d.year, d.addressee, d.place, d.type, f.fulltext FROM documents AS d, fulltext AS f WHERE d.filename IS f.filename;';

# create a full text table
echo "Step #1 of 4: creating table to contain full text" >&2
echo $DROPFULLTEXT   | sqlite3 $DB 
echo $CREATEFULLTEXT | sqlite3 $DB 

# initialize and fill a transaction
echo "Step #2 of 4: reading full text; please be patient..." >&2
echo "BEGIN TRANSACTION;" > $TRANSACTION
find "$TXT" -name "*.txt" | sort -rn | while read FILE; do

	# debug, sort of (mostly)
	printf "$FILE\t\r" >&2
	
	# get the key (id)
	ID=$( basename "$FILE" '.txt' )
	ID=$( echo $ID | sed "s/'/''/g" )
	
	# get the full text and normalize/escape it; removing slashes (/) is probably okay
	FULLTEXT=$( cat "$FILE" )
	FULLTEXT=$( echo $FULLTEXT | tr '\r' ' ' | tr '\n' ' ' )
	FULLTEXT=$( echo $FULLTEXT | sed "s/[[:punct:]]/ /g" )
	FULLTEXT=$( echo $FULLTEXT | sed "s/ +/ /g" )
	
	# update the transaction
	echo $TEMPLATE | sed "s/##ID##/$ID/" | sed "s/##FULLTEXT##/$FULLTEXT/" >> $TRANSACTION
	
done

# close the transaction and update the database
echo "Step #3 of 4: writing full text to database" >&2
echo "END TRANSACTION;" >> $TRANSACTION
cat $TRANSACTION | sqlite3 $DB

echo "Step #4 of 4: indexing" >&2
echo $DROPINDX   | sqlite3 $DB
echo $CREATEINDX | sqlite3 $DB
echo $INDEX      | sqlite3 $DB

# done
echo "Done. Happy searching!" >&2
exit
