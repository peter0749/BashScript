#!/bin/bash
# Read from the file words.txt and output the word frequency list to stdout.
awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v " " S[v] } } ' words.txt  | sort -rn -k2
