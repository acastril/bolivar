#!/usr/bin/env bash

# filter.sh - a front-end to filter.py
# Usage: find corpus -name *.txt | parallel ./bin/filter.sh {}


# configure
FILE=$1
FILTERED='./filtered'
FILTER='./bin/filter.py'

# compute output
LEAF=$( basename $FILE .txt )
OUTPUT="$FILTERED/$LEAF.txt"

# do the work and done
$FILTER $FILE > $OUTPUT
exit
