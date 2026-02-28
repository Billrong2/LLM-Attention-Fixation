#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    p=$2
    prev_p=$((p - 1))
    if [ $prev_p -lt 0 ]; then
        prev_p=$(( ${#nums[@]} - 1 ))
    fi
    echo ${nums[prev_p]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 8 2 5 3 1 9 7" "6") = "1" ]]
}

run_test
