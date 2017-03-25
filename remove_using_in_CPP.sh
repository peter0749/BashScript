#!/bin/bash

ARR=()
REGEX="\(using std::\)\{1\}[^\;]*\;"
grep -p "$REGEX" $1 > ./tmp
sed "s/using std:://g; s/\;//g" ./tmp  > ./tmp2
mv ./tmp2 ./tmp

if [ "$2" == "-freq" ]; then
    awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v " " S[v] } } ' ./tmp | sort -rn -k2 > ./tmp2
else
    awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v } } ' ./tmp | sort -rn -k2 > ./tmp2
fi

mv ./tmp2 ./result.txt
rm -f ./tmp

echo "Want to purge your code? Backup file will save as *.old (Y/[n])"
read reply
if [ "$reply" == "Y" ] || [ "$reply" == "y" ]; then
    cp $1 "$1.old"
    VAR=`awk 'BEGIN{ORS=" ;"} {
    print "s\/" $1 "\/std::" $1 "\/g "
    
}' ./result.txt`
    LEN=`echo "${#VAR} - 1" | bc`
    SUB=${VAR:0:LEN}
    echo $SUB

    if [ "$(which parallel)" != "" ]; then
    #if [[ 0 -eq 1 ]]; then
        cat $1 | parallel --pipe "sed \"$SUB\" " > ./tmp2
        cat ./tmp2 | parallel --pipe "sed \"s/std::std::/std::/g\" " > ./tmp3
    else
        sed "$SUB" $1 > ./tmp2
        sed "s/std::std::/std::/g" ./tmp2  > ./tmp3
    fi
    rm -f indent.src ./tmp2
    echo "gg=G" >> indent.src
    echo ":wq" >> indent.src
    vim -s indent.src ./tmp3
    mv ./tmp3 $1
    rm -f indent.src ./tmp3
else
    echo "Okay, bye!"
fi
