#!/bin/bash
grep Note_on_c test.csv | tr -d ' ' | cut -d ',' -f 5 | awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v " " S[v] } } ' | sort -n -k1
