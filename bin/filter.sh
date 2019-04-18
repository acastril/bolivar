#!/usr/bin/env bash


FILE=$1
FILTERED='./filtered'
FILTER='./bin/filter.py'

LEAF=$( basename $FILE .txt )
OUTPUT="$FILTERED/$LEAF.txt"

$FILTER $FILE > $OUTPUT

