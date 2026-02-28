#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    declare -A d
    for key in $1; do
        d[$key]=$2
    done
    
    count=1
    for key in $1; do
        if [ ${d[$key]} -eq ${d[$count]} ]; then
            unset d[$count]
        fi
        count=$((count+1))
    done
    
    for key in "${!d[@]}"; do
        echo "$key:${d[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 1 1" "3") = "" ]]
}

run_test
