#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for ((i=${#nums[@]}-1; i>=0; i-=3)); do
        if [[ ${nums[i]} -eq 0 ]]; then
            echo "false"
            return
        fi
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 0 1 2 1") = "false" ]]
}

run_test
