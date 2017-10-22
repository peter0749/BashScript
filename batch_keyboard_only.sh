#!/bin/bash

find data -type f -iname '*.mid' -exec sh -c 'fn=$(echo "{}" | cut -d"/" -f2); ./script/keyboard_only.sh "{}" "./mod/$fn" ' \;
