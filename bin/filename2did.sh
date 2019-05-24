#!/usr/bin/env bash

# filename2did.sh - given a filename, output SQL update statements

# Eric
# May 24, 2019 - first cut


# configure
FILENAME2DID='./bin/filename2did.py'

FILE=$1
KEY=$( basename $FILE '.txt' )

DID=$( $FILENAME2DID $FILE )

echo "UPDATE documents SET did = '$DID' WHERE filename is '$KEY';"
exit
