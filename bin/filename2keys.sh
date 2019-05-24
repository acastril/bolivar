#!/usr/bin/env bash

# filename2keys.sh - given a file name, output SQL create statements

# Eric
# May 24, 2019 - first cut

FILE=$1
KEY=$( basename $FILE '.txt' )

echo "INSERT INTO documents ( filename ) VALUES ( '$KEY' );"
exit
