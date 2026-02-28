#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is an integer
f() {
    local text=$1
    local s=$2
    local e=$3
    
    local sublist="${text:s:e-s}"
    
    if [ -z "$sublist" ]; then
        echo "-1"
    else
        echo $(expr index "$sublist" $(echo "$sublist" | tr ' ' '\n' | sort -n | head -n 1))
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "happy" "0" "3") = "1" ]]
}

run_test
