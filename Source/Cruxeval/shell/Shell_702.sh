#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for i in $(seq $(( $count - 1 )) -1 0); do
        elem=${nums[0]}
        nums=("${nums[@]:1}")
        nums=("${nums[@]:0:$i}" "$elem" "${nums[@]:$i}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 -5 -4") = "-4 -5 0" ]]
}

run_test
