#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    n=$2
    pos=$((${#nums[@]} - 1))
    for ((i=-${#nums[@]}; i<0; i++)); do
        nums=("${nums[@]:0:$pos}" "${nums[i]}" "${nums[@]:$pos}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "14") = "" ]]
}

run_test
