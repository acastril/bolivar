#!/usr/bin/env bash

# get.sh - given a file of urls and extension, get & save the content of each; a front-end to get.py


# configure
GET='./get.py'
LEAF='item'

# sanity check
if [[ -z $1 || -z $2 ]]; then
	echo "Usage: $0 <file> <extension>" >&2
	exit
fi

# get input
INPUT=$1
EXTENSION=$2

# initialize
INDEX=0

# process each line from the input file; read a URL
while read URL; do

	# debug
	echo "$URL" >&2
	
	# increment and create cool output name
	((INDEX++))
	FILE="$LEAF-$( printf '%02d' $INDEX ).$EXTENSION"
	
	# get the url and save its contents
	$GET $URL > $FILE

done < $INPUT

# fini
exit
