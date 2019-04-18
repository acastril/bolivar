#!/usr/bin/env python


import sys
import re

# sanity check

if len( sys.argv ) != 2 :
	sys.stderr.write ( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()
	

# get input

file = sys.argv [1]

# read the file line by line
with open( file ) as handle :
	for line in handle : 
	
		# Do substitutions!
		line = re.sub( "\t" , " ", line)
		line = re.sub( " +" , " ", line)
		line = re.sub( " \n" , "", line)
		line = re.sub( "­" , "", line)
		
		if ( line == "\n" ) : continue
		
		# Check for end
		
		if ( line == ' Secciones\n') : break
		
		else : print (line)

#output & done



exit()