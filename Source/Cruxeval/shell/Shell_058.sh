#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for (( i=0; i<count; i++ )); do
        j=$(( i % 2 ))
        nums+=(${nums[j]})
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 0 0 1 1") = "-1 0 0 1 1 -1 0 -1 0 -1" ]]
}

run_test
