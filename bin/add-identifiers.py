#!/usr/bin/env python

# add-identifiers.py - given a file, output SQL update statement with document identifier

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# April 26, 2021 - first investigations


# configure
TEMPLATE = "UPDATE documents SET did = '##DID##' WHERE filename is '##KEY##';"

# require
import sys
import os

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# get input
file = sys.argv[ 1 ]

# initialize: key, paragraph, and tokens
key       = os.path.splitext( os.path.basename( file ) )[0]
paragraph = open( file ).read().split( '\n\n' )[ 0 ]
tokens    = paragraph.split()

# check for valid values
if ( tokens[ 0 ] == 'DOCUMENTO' ) and ( ( tokens[ 1 ].isnumeric() ) ) :
	
	# build SQL
	sql = TEMPLATE
	sql = sql.replace( '##DID##', tokens[ 1 ] )
	sql = sql.replace( '##KEY##', key )
	
	# output
	sys.stderr.write( sql + "\n" )
	print( sql )

# done
exit()


