#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    nums=()
    for num in ${!nums[@]}; do
        nums[num]=$((num*2))
    done
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 3 2 1 2 -1 4 2") = "" ]]
}

run_test
