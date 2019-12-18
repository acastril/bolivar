#!/usr/bin/env python

# filter.py - given a file name, clean the file a bit


# require
import sys
import re

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()
	

# get input
file = sys.argv [1]

# initialize
data = ''

# open the file
with open( file ) as handle :

	# read a line
	for line in handle  : 
	
		# do substitutions
		line = re.sub( "\t" , " ", line)
		line = re.sub( " +" , " ", line)
		line = re.sub( "^ " , "", line)
		line = re.sub( "\." , "", line)
		line = re.sub( " \n" , "", line)
		line = re.sub( "­" , "", line)

		# normalize (eventually) for Solr
		line = re.sub( "ñ" , "n", line)
		line = re.sub( "ó" , "o", line)
		
		# check for blank line
		if ( line == "\n" ) : continue
		
		# check for end
		if ( line == 'Secciones\n') : break
		
		# update the data
		else : data = data + line + "\n"


# remove multiple carriage returns, output, and done
data = re.sub( "\n+", "\n\n", data )
print( data )
exit()