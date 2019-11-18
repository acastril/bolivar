if [[ -z $1 ]]; then
	echo "Usage: $0 <word>" >&2
	exit
fi

QUERY=$1
find ./filtered -name *.txt | while read FILE; do

	grep -l "$QUERY" $FILE

done