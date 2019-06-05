#!/usr/bin/env python

# extracting the main type of correspondence

# require
import sys

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# initialize
name     = sys.argv[1]
fhand    = open(name)
maintype = 'UNKNOWN'

# loop through text for each line and format lines
for line in fhand:
	line = line.rstrip()

	# Isolate lines that begin with 'Portada'
	if not line.startswith('Portada'): continue 
	words = line.split()

	# Go through 'Portada' line to search for main type
	for word in words:
		if word == 'Oficial':
			maintype= 'Oficial'
		elif word == 'Personal':
			maintype = 'Personal'

	print( maintype )
	