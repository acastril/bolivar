#!/usr/bin/env bash

# make-subset-filename - given key, create a subset of content

# Eric Lease Morgan <emorgan@nd.edu>
# October 24, 2019 - first cut

 
# configure
FILTERED='./filtered'
SUBSET='./subset'

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <file> <another file> [<yet another file>...]" >&2
	exit
fi

# create subset directory
rm -rf $SUBSET
mkdir -p $SUBSET

# loop through each item in the input
for FILE in "$@"; do

	# re-initialize and do the work
	FILE="$FILTERED/$FILE.txt"
	cp $FILE $SUBSET
	
# fini
done
exit

