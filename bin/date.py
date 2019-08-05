#!/usr/bin/env python

# Aim is to extract the corresponding date for each document

pattern = "\d+ DE \w+ DE \d\d\d\d"
import sys
import re

# sanity check
if len( sys.argv ) != 2 :
        sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
        exit()

# get input
file = sys.argv[ 1 ]

with open(file) as handle: line = handle.readline()
date = re.findall(pattern,line)
if len(date) == 1:
	date = date[0]
	parts = date.split()
	day = parts[0]
	month = parts[2]
	year = parts[4]
	print("UPDATE documents SET day = '%s' WHERE filename is 'article-4444'"  % day )
