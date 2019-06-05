#!/usr/bin/env bash

#extracts main type for Bolivar correspondence; front end to maintype2did.py 
#Alejandro C. June 5 2019 alex.castrillon@gmail.com

# finds all files and passes them on to code 

find filtered -name "*.txt" -exec python ./bin/maintype2did.py {} \;