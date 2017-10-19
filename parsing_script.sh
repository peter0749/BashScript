#!/bin/bash

## delete the midi files without piano
find . -type f -iname '*.mid' -exec sh -c 'midicsv "{}" o.csv && ! grep -q -e "Program_c, \d, 0$" -e "Program_c, \d, 6$" o.csv && rm "{}" ' \;
## delete the midi files with # of piano track != 2
find . -type f -iname '*.mid' -exec sh -c 'midicsv "{}" o.csv && grep -e "Program_c, \d, 0$" -e "Program_c, \d, 6$" o.csv | if [[ `wc -l` -ne 2 ]]; then rm "{}"; fi ' \;

rm o.csv
