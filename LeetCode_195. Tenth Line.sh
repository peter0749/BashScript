# Read from the file file.txt and output the tenth line to stdout.
#if [ "`wc -l file.txt | awk '{print $1}'`" -ge "10" ]; then cat file.txt | head -n 10 | tail -n 1; fi
awk 'NR == 10' file.txt
#tail -n+10 file.txt | head -1
