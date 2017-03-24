#!/bin/bash
find . -type f -exec sh -c "sed s/categories:/tags:/g {} > ./tmp && mv ./tmp {}"  \;
