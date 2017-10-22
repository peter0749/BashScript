#!/bin/bash

csvfile=$(mktemp)

midicsv "$1" "$csvfile"

colCnt=`grep Note_on_c "$csvfile" | awk 'BEGIN{FS=","} {print NF}' | sort -nu | head -n1`

if [[ $colCnt -lt 5 ]]; then
    rm "$csvfile"
    exit 1 ## error
fi

grep Note_on_c "$csvfile" | tr -d ' ' | awk ' BEGIN{ FS="," } { S[$5]++; } END{ for(v in S){ print v " " S[v] } } ' | sort -n -k1

rm "$csvfile"

exit 0 ## normal
