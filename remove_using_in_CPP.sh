#!/bin/bash

echo "Usage: ./purge namespace filename [--freq]"
echo "Note: Use argument --freq to print each frequency of syntax in the namespace"

if [[ $# -lt 2 ]]; then
    exit;
fi

REGEX="\(using $1::\)\{1\}[^\;]*\;"
grep -p "$REGEX" $2 > ./tmp
sed "s/using $1:://g; s/\;//g" ./tmp  > ./tmp2
mv ./tmp2 ./tmp

if [ "$3" == "-freq" ]; then
    awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v " " S[v] } } ' ./tmp | sort -rn -k2 > ./tmp2
else
    awk ' BEGIN{ FS=" " } { for(i=1; i<=NF; ++i) S[$i]++; } END{ for(v in S){ print v } } ' ./tmp | sort -rn -k2 > ./tmp2
fi

mv ./tmp2 ./result.txt
rm -f ./tmp

echo "Want to purge your code? Backup file will save as *.old (Y/[n])"
read reply
# perl: cat OOP/HW1/SubFactorial.cpp | perl -ne 's/(?<!std::)cout/std::cout/g; print;'
if [ "$reply" == "Y" ] || [ "$reply" == "y" ]; then
    cp $2 "$2.old"
    VAR=`awk -v x=$1 ' BEGIN {ORS=" "} {
    print "s\/\(\?\<\!" x "\:\:\)(\?\<\!include<)(\?\<\!include <) *" $1 "\/ " x "::"$1 "\/g;"
    
}' ./result.txt`
    LEN=`echo "${#VAR} - 1" | bc`
    SUB=${VAR:0:LEN}
    echo "Some regex:"
    echo $SUB
    rm -f ./tmp2
    cat $2 | perl -ne 's/[[:space:]]{2,}/ /g; print;' > ./tmp2
    if [ "$(which parallel)" != "" ]; then
        cat ./tmp2 | parallel --pipe "perl -ne \"$SUB ; print ;\" " > ./tmp3
    else
        cat ./tmp2 | perl -ne "$SUB ; print ;" > ./tmp3
    fi
    rm -f indent.src ./tmp2
    echo "gg=G" >> indent.src
    echo ":wq" >> indent.src
    sed -e "s/using *$1::.*;//g" -e "/^[[:blank:]]*$/d" ./tmp3 > ./tmp4  # delete using statement, delete empty line (include blank lines)
    rm ./tmp3
    vim -s indent.src ./tmp4
    mv ./tmp4 $2
    rm -f indent.src ./tmp4
else
    echo "Okay, bye!"
fi
