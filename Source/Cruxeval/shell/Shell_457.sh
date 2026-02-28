#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=($(seq 0 $(( ${#nums[@]} - 1 ))))
    for i in $(seq 0 $(( ${#nums[@]} - 1 ))); do
        unset 'nums[${#nums[@]}-1]'
        if [ ${#count[@]} -gt 0 ]; then
            unset 'count[0]'
        fi
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 1 7 5 6") = "" ]]
}

run_test
