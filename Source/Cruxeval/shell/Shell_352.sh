#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    index=$(( ${#nums[@]} / 2 ))
    echo ${nums[index]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 -3 -5 -7 0") = "-5" ]]
}

run_test
