#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    length=${#nums[@]}
    middle=$(( $length / 2 ))
    echo "${nums[@]:$middle:$length} ${nums[@]:0:$middle}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 1") = "1 1 1" ]]
}

run_test
