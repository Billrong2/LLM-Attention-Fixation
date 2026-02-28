#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    if [ $count -eq 0 ]; then
        nums=($(yes 0 | head -n ${nums[-1]}))
    elif [ $((count % 2)) -eq 0 ]; then
        nums=()
    else
        nums=("${nums[@]:$((count / 2))}")
    fi
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-6 -2 1 -3 0 1") = "" ]]
}

run_test
