#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for ((i=${#nums[@]}-1; i>=0; i--)); do
        if (( ${nums[i]} % 2 == 1 )); then
            nums=("${nums[@]:0:i+1}" "${nums[i]}" "${nums[@]:i+1}")
        fi
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 3 4 6 -2") = "2 3 3 4 6 -2" ]]
}

run_test
