#!/usr/bin/env python

# get.py - given a URL, retrieve a Web page and send it to standard output

# require
import urllib.request
import sys

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <url>\n" )
	exit()

# get input
url = sys.argv[ 1 ]

# do the work, output, and done
page = urllib.request.urlopen( url )
print( page.read().decode() )
exit()
