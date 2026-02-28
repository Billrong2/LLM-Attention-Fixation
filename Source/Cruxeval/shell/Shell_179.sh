#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for (( i=-count+1; i<0; i++ )); do
        nums=("${nums[i]}" "${nums[@]}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7 1 2 6 0 2") = "2 0 6 2 1 7 1 2 6 0 2" ]]
}

run_test
