#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for (( i=0; i < count/2; i++ )); do
        tmp=${nums[i]}
        nums[i]=${nums[count-i-1]}
        nums[count-i-1]=$tmp
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 6 1 3 1") = "1 3 1 6 2" ]]
}

run_test
