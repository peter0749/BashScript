#!/bin/bash

tmpfile=$(mktemp)
output=$(mktemp)

midicsv "$1" "$tmpfile"
head -n1 "$tmpfile" > "$output"

grep Program_c "$tmpfile" | awk 'BEGIN{ FS="," } {if($5<8) print $1}' | while read line; do perl -sne 'if (/^$track,/) { print }' -- -track="$line" "$tmpfile" >> "$output" ; done

tail -n1 "$tmpfile" >> "$output"

csvmidi "$output" "$2"

exit 0
