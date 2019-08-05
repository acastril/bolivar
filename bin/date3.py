#date3.py

# Aim is to extract the corresponding date for each document

import sys

# sanity check
if len( sys.argv ) != 2 :
        sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
        exit()

# get input
file = sys.argv[ 1 ]

fhand = open(file)

# loop through text for each line and format lines
for line in fhand:
	line = line.rstrip()

	# Isolate lines that begin with 'Portada'
	if not line.startswith('DOCUMENTO'): continue 
	words = line.split()
	month = ''
	year = ''
	# Go through 'DOCUMENTO' line to search for main type
	for word in words:
		
		if word == 'JANUARIO':
			month= 'January'
		elif word == 'FEBRERO':
			month= 'February'
		elif word == 'MARZO':
			month= 'March'
		elif word == 'ABRIL':
			month= 'April'
		elif word == 'MAYO':
			month= 'May'
		elif word == 'JUNIO':
			month= 'June'
		elif word == 'JULIO':
			month= 'July'
		elif word == 'AUGOSTO':
			month= 'August'
		elif word == 'SEPTIEMBRE':
			month= 'September'
		elif word == 'OCTUBRE':
			month= 'October'
		elif word == 'NOVIEMBRE':
			month= 'November'
		elif word == 'DICIEMBRE':
			month= 'December'
		elif word == '1790':
			year= '1790'
		elif word == '1791':
			year= '1791'
		elif word == '1792':
			year= '1792'
		elif word == '1793':
			year= '1793'
		elif word == '1794':
			year= '1794'
		elif word == '1795':
			year= '1795'
		elif word == '1796':
			year= '1796'
		elif word == '1797':
			year= '1797'
		elif word == '1798':
			year= '1798'
		elif word == '1799':
			year= '1799'
		elif word == '1800':
			year= '1800'
		elif word == '1801':
			year= '1801'
		elif word == '1802':
			year= '1802'
		elif word == '1803':
			year= '1803'
		elif word == '1804':
			year= '1804'
		elif word == '1805':
			year= '1805'
		elif word == '1806':
			year= '1806'
		elif word == '1807':
			year= '1807'
		elif word == '1808':
			year= '1808'
		elif word == '1809':
			year= '1809'
		elif word == '1810':
			year= '1810'
		elif word == '1811':
			year= '1811'
		elif word == '1812':
			year= '1812'
		elif word == '1813':
			year= '1813'
		elif word == '1814':
			year= '1814'
		elif word == '1815':
			year= '1815'
		elif word == '1816':
			year= '1816'
		elif word == '1817':
			year= '1817'
		elif word == '1818':
			year= '1818'
		elif word == '1819':
			year= '1819'
		elif word == '1820':
			year= '1820'
		elif word == '1821':
			year= '1821'
		elif word == '1822':
			year= '1822'
		elif word == '1823':
			year= '1823'
		elif word == '1824':
			year= '1824'
		elif word == '1825':
			year= '1825'
		elif word == '1826':
			year= '1826'
		elif word == '1827':
			year= '1827'
		elif word == '1828':
			year= '1828'
		elif word == '1829':
			year= '1829'
		elif word == '1830':
			year= '1830'
			
	print( month )
	print ( year )