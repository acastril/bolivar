#!/usr/bin/env bash

#extracts main type for Bolivar correspondence; front end to maintype2did.py 
#Alejandro C. June 5 2019 alex.castrillon@gmail.com

# finds all files and passes them on to code 

# configure
MAINTYPE2DID='./bin/maintype2did.py'

FILE=$1
KEY=$( basename $FILE '.txt' )

MAINTYPE=$( $MAINTYPE2DID $FILE )

echo "UPDATE documents SET type = '$MAINTYPE' WHERE filename is '$KEY';"
exit
