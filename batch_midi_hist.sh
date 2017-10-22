#!/bin/bash

find data -type f -iname '*.mid' -exec sh -c 'fm=$(echo "{}" | cut -d"/" -f2);  ./make_histogram.sh "{}" > "hist/$fm.hist"' \;
