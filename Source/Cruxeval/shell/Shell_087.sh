#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for i in $(seq $((${#nums[@]} - 1)) -1 0); do
        echo -n "${nums[i]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 9 3 1 -2") = "-2139-1" ]]
}

run_test
