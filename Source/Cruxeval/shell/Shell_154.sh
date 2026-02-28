#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    IFS=' ' read -ra ADDR <<< "$1"
    for ((idx=${#ADDR[@]}-1; idx>=0; idx--)); do
        result+=${ADDR[idx]}
        if [[ $idx -ne 0 ]]; then
            result+="  "
        fi
    done
    echo "$2  $result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hello There" "*") = "*  There  Hello" ]]
}

run_test
