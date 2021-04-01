#!/usr/bin/env python

# txt2ner-paragraph.py - given a file, output the first paragraph and its named entities

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# March 4, 2021 - first cut


# configure
MODEL = 'es_core_news_lg'

# require
import sys
import spacy
import os

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# get input
file = sys.argv[ 1 ]

# initialize
nlp = spacy.load( MODEL )
key = os.path.splitext( os.path.basename( file ) )[0]

# open the given file and get the first paragraph
paragraph = open( file ).read().split( '\n\n' )[ 0 ]
print( paragraph + "\n" )

# model the paragraph and process each entity
doc = nlp( paragraph )
e   = 0
for entity in doc.ents : 
	
	# increment and output
	e += 1
	print( "\t".join( [ key, str( e ), entity.text, entity.label_ ] ) )

# delimit and done
print( "\n\n" )
exit
