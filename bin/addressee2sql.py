#!/usr/bin/env python

# addressee2sql - given a file, output SQL denoting the addressee

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# March  5, 2021 - first cut
# March 15, 2021 - outputting to a file
# March 31, 2021 - outputting SQL

# configure
SIGNALS  = [ 'DIRIGIDA AL ', 'DIRIGIDO AL ', 'DIRIGIDA A ', 'PARA EL TENIENTE ', 'PARA EL TTE ', 'PARA EL ', 'PARA DON ' ]
SQL      = './tmp/addressees'
TEMPLATE = "UPDATE documents SET addressee = '%s' WHERE filename is '%s';\n"

# require
import sys
import os

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# get input
file = sys.argv[ 1 ]

# initialize
key = os.path.splitext( os.path.basename( file ) )[0]

# open the given file and get the first paragraph
paragraph = open( file ).read().split( '\n\n' )[ 0 ]

# loop through each signal
for signal in SIGNALS :

	# look for the signal
	if paragraph.find( signal ) > 0 :
	
		# determine where the addressee starts and ends
		start = paragraph.find( signal ) + len( signal )
		end   = paragraph.find( ',', start )
		
		# extract a (probable) addressee and escape it
		addressee = paragraph[ start:end ]
		addressee = addressee.replace( "'", "''" )
		
		# output and break
		file   = SQL + '/' + key + '.sql'
		handle = open( file, 'a' )
		handle.write( TEMPLATE % ( addressee, key ) )
		handle.close()
		break

# done
exit()


