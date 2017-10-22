#!/bin/bash

tmpfile=$(mktemp)
output=$(mktemp)
tracknum=$(mktemp)

midicsv "$1" "$tmpfile"

ts=1
grep Program_c "$tmpfile" | awk 'BEGIN{ FS="," } {if($5<8) print $1}' > "$tracknum"
l=`wc -l "$tracknum" | perl -n -e 's/^[[:space:]]*//g; s/[[:space:]]*$//g; s/[[:space:]]{2,}//g; print' | cut -d ' ' -f1`

awk -v l="$l" 'BEGIN{ FS="," } {if(NR==1) print $1 "," $2 "," $3 "," $4 "," l "," $6 }' "$tmpfile" >> "$output"

cat "$tracknum" | while read line
    do
        perl -sne 'if (/^$track,/) { print }' -- -track="$line" "$tmpfile"  | awk -v a=$ts 'BEGIN{FS=","} {printf a; for (i=2; i<=NF; ++i) { printf "," $i; } print "" }' >> "$output"
        ts=$((ts+1))
    done

tail -n1 "$tmpfile" >> "$output"

csvmidi "$output" "$2"

rm "$tracknum"
rm "$tmpfile"
rm "$output"

exit 0
