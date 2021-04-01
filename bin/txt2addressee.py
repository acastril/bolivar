#!/usr/bin/env python

# txt2addressee.py - given a file, try to extract the addressee

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# March  5, 2021 - first cut
# March 15, 2021 - outputting to a file

# really good: 'DIRIGIDA AL ', 'DIRIGIDO ', 'DIRIGIDA ', 

# configure
SIGNALS = [ 'DIRIGIDO AL ', 'DIRIGIDA AL ', 'DIRIGIDO ', 'DIRIGIDA ', 'PARA ', 'AL ' ]
DIRECTORY = './addresees'

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
		
		# extract a (possible) addressee
		addressee = paragraph[ start:end ]
		
		# output and break
		file   = DIRECTORY + '/' + key + '.tsv'
		handle = open( file, 'a' )
		handle.write("\t".join( [ key, paragraph, signal, addressee ] ) + "\n" )
		handle.close()
		break

# done
exit()


