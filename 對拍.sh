#!/bin/bash
<<COMM
or just:
O1="$(mktemp)"
O2="$(mktemp)"
tee >("./$1" > "$O1")  >("./$2" > "$O2") > /dev/null
if sync && diff "$O1" "$O2" &> /dev/null; then
    echo "AC"
else
    echo "WA"
fi
COMM
if [[ $# -ge 2 ]]; then
    program1="$1"
    program2="$2"
else
    >&2 echo "Usage: $0 program1 program2"
    exit 1
fi
OUTPUT1="$(mktemp -t oj-test-input-1-XXXXXX)"
OUTPUT2="$(mktemp -t oj-test-input-2-XXXXXX)"
tee >("./$program1" > "$OUTPUT1")  >("./$program2" > "$OUTPUT2") > /dev/null
if sync && diff "$OUTPUT1" "$OUTPUT2" &> /dev/null; then
    echo "AC"
else
    echo "WA"
fi
rm "$OUTPUT1"
rm "$OUTPUT2"
