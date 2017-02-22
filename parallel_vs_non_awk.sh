#!/bin/bash

rm -f temp.txt bigfile.txt

for((i=0; i<10000; ++i)); do
    echo $RANDOM >> temp.txt
done

for((i=0; i<3000; ++i)); do
    cat temp.txt >> bigfile.txt
done

time cat bigfile.txt |  awk '{s+=$1} END {print s}'
time cat bigfile.txt | parallel --pipe awk \'{s+=\$1} END {print s}\' | awk '{s+=$1} END {print s}'

rm -f temp.txt bigfile.txt
