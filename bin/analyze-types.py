#!/usr/bin/env python

# analyze-types.py - given a directory of files, count & tabulate the frequency of initial words

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# April 1, 2021 - first cut


# configure
DIRECTORY = './filtered'
START     = 2
END       = 4
HEADER    = ( 'count', 'word' )
STOPWORDS = ( 'DE', 'DEL', 'UNA', 'EL', 'A', 'PARA', 'BOLIVAR', 'Y' )

# require
import sys
import os
import string

# initialize
words = {}
print( "\t".join( HEADER ) )

# loop thorough each file in the given directory
for file in os.listdir( DIRECTORY ) :

	# open the given file and get the first paragraph
	paragraph = open( DIRECTORY + '/' + file ).read().split( '\n\n' )[ 0 ]

	# slice the paragraph to extract only a few words
	slice = paragraph.split()[ START:END ]
	
	# process each word in the slice; count & tabulate the given words
	for word in slice :
			
		# remove any punctuation
		word = word.translate( str.maketrans( '', '', string.punctuation ) )	

		# ignore non-words
		if word == '' : continue
		
		# ignore stop words
		if word in STOPWORDS : continue
		
		# increment or...
		if word in words : words[ word ] += 1
		
		# create
		else : words[ word ] = 1

# sort the counts & tabulations; tricky
words = { key : value for key, value in sorted( words.items(), key=lambda item: item[1], reverse=True ) }

# process each word
for word in words :
	
	# parse and output
	count = str( words[ word ] )
	print( "\t".join( ( count, word ) ) )
		
# done
exit()


