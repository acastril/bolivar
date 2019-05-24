#!/usr/bin/env python

# filename2did.py - given a filename, output the document identifier

# require
import sys

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# initialize
file = sys.argv [1]

# open the file
with open( file ) as handle :  

	# read a line
	line = handle.readline()

	# parse and output
	word = line.split()
	print( word[ 1 ] )
	
exit()
