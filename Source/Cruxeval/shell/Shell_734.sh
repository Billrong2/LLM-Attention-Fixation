#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for (( i=${#nums[@]}-1; i>=0; i-- )); do
        if (( ${nums[i]} % 2 == 0 )); then
            unset 'nums[i]'
        fi
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 3 3 7") = "5 3 3 7" ]]
}

run_test
