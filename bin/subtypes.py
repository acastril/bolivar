#!/usr/bin/env python

# Aim is to extract the corresponding subtype for each document

pattern = "\d+ \w+ DE "
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
subtype = re.findall(pattern,line)[0].strip()
fields = subtype.split(" ")
print(subtype,fields[1])