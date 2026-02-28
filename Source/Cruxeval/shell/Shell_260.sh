#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    nums=($1)
    start=$2
    k=$3
    reversed_part=($(echo "${nums[@]:$start:$k}" | tr ' ' '\n' | tac | tr '\n' ' '))
    nums=("${nums[@]:0:$start}" "${reversed_part[@]}" "${nums[@]:$((start+k))}")
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4 5 6" "4" "2") = "1 2 3 4 6 5" ]]
}

run_test
