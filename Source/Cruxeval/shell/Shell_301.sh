#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for ((i=-count+1; i<0; i++))
    do
        nums+=(${nums[i]} ${nums[i]})
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 6 2 -1 -2") = "0 6 2 -1 -2 6 6 -2 -2 -2 -2 -2 -2" ]]
}

run_test
