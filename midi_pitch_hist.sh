#!/bin/bash

csvfile=$(mktemp)

midicsv "$1" "$csvfile"

colCnt=`grep Note_on_c "$csvfile" | awk '{FS=","} {print NF}' | sort -nu | head -n1`

if [[ $colCnt -lt 5 ]]; then
    exit 1 ## error
fi

grep Note_on_c "$csvfile" | tr -d ' ' | cut -d ',' -f 5 | awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v " " S[v] } } ' | sort -n -k1

rm "$csvfile"

exit 0 ## normal
