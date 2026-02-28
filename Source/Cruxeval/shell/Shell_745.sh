#!/bin/bash
# $1 is a string
f() {
    suffix_start=$(expr index "$1" "@")
    if [ $suffix_start -gt 0 ]; then
        suffix_start=$((suffix_start + 1))
        rest_of_address=${1:$suffix_start}
        count=$(echo $rest_of_address | tr -cd '.' | wc -c)
        if [ $count -gt 1 ]; then
            first_two_parts=$(echo $rest_of_address | cut -d'.' -f1,2)
            len_first_two_parts=${#first_two_parts}
            address=${1:0:$((${#1}-len_first_two_parts-1))}
        else
            address=$1
        fi
    else
        address=$1
    fi
    echo $address
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "minimc@minimc.io") = "minimc@minimc.io" ]]
}

run_test
