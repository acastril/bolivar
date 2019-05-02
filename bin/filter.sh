#!/usr/bin/env bash

# filter.sh - a front-end to filter.py
# Usage: find corpus -name *.txt | parallel ./filter.sh {}


FILE=$1
FILTERED='./filtered'
FILTER='./bin/filter.py'

LEAF=$( basename $FILE .txt )
OUTPUT="$FILTERED/$LEAF.txt"

$FILTER $FILE > $OUTPUT

