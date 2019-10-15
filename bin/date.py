#!/usr/bin/env python

# Aim is to extract the corresponding date for each document

pattern = "\d+ DE \w+ DE \d\d\d\d"
import sys
import re
import os

# sanity check
if len( sys.argv ) != 2 :
        sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
        exit()

# get input
file = sys.argv[ 1 ]

# extracting key/filename
key, extension = os.path.splitext(file)
key = os.path.split(key)[1]

with open(file) as handle: line = handle.readline()
date = re.findall(pattern,line)
if len(date) == 1:
	date = date[0]
	parts = date.split()
	day = parts[0]
	month = parts[2]
	year = parts[4]
	print("UPDATE documents SET day = '%s' WHERE filename is '%s';"  % (day, key))
	print("UPDATE documents SET month = '%s' WHERE filename is '%s';"  % (month, key) )
	print("UPDATE documents SET year = '%s' WHERE filename is '%s';"  % (year, key) )
else: print(file)