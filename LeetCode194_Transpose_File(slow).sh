# Read from the file file.txt and print its transposed content to stdout.
#!/bin/bash
k=i=0
while read line; do
    j=0
    for v in $line; do
        ARR[$k]=$v
        j=$((j+1))
        k=$((k+1))
    done
    i=$((i+1))
done <file.txt
nrow=$i
ncol=$j
for ((j=0; j<ncol; ++j)); do
    echo -n ${ARR[$j]}
    for ((i=1; i<nrow; ++i)); do
        echo -n " ${ARR[$((i*ncol+j))]}"
    done
    echo
done
