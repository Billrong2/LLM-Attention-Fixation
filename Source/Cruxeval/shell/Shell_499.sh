#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is a string
f() {
    text=$1
    length=$2
    fillchar=$3
    size=${#text}
    if [ $size -ge $length ]; then
        echo $text
    else
        padding=$(( ($length - $size) / 2 ))
        for i in $(seq 1 $padding); do
            text="$fillchar$text$fillchar"
        done
        if [ $(($size + padding * 2)) -lt $length ]; then
            text="$fillchar$text"
        fi
        echo $text
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "magazine" "25" ".") = ".........magazine........" ]]
}

run_test
