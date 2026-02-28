#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    sorted_nums=($(echo $1 | tr ' ' '\n' | sort -n))
    for ((i = 0; i < $2; i++)); do
        echo ${sorted_nums[i]}
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 2 3 4 5" "1") = "1" ]]
}

run_test
