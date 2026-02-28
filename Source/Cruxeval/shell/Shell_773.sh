#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    n=$2
    echo ${nums[n]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-7 3 1 -1 -1 0 4" "6") = "4" ]]
}

run_test
