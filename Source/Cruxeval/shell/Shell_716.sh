#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    while [ ${#nums[@]} -gt $((count/2)) ]; do
        nums=()
    done
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 1 2 3 1 6 3 8") = "" ]]
}

run_test
