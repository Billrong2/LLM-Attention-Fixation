#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is a string
f() {
    text=$1
    position=$2
    value=$3
    length=${#text}
    index=$(( ($position % ($length + 2)) - 1 ))
    if [ $index -ge $length ] || [ $index -lt 0 ]; then
        echo $text
    else
        text_list=($(echo $text | sed 's/./& /g'))
        text_list[$index]=$value
        echo ${text_list[*]}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1zd" "0" "m") = "1zd" ]]
}

run_test
