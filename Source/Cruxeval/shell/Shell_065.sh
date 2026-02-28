#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    index=$2
    echo $(( ${nums[index]} % 42 + 2 * ${nums[index]} ))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 2 0 3 7" "3") = "9" ]]
}

run_test
