#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for (( i=0; i<count; i++ )); do
        nums=("${nums[@]:0:i}" $(( ${nums[i]} * 2 )) "${nums[@]:i}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 8 -2 9 3 3") = "4 4 4 4 4 4 2 8 -2 9 3 3" ]]
}

run_test
