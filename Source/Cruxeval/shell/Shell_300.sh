#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=1
    for ((i=count; i<${#nums[@]}-1; i+=2)); do
        nums[i]=$(( ${nums[i]} > ${nums[count-1]} ? ${nums[i]} : ${nums[count-1]} ))
        count=$((count + 1))
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3") = "1 2 3" ]]
}

run_test
