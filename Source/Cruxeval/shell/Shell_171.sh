#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=$((${#nums[@]} / 2))
    for (( i=0; i<count; i++ )); do
        unset 'nums[0]'
        nums=("${nums[@]}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 4 1 2 3") = "1 2 3" ]]
}

run_test
