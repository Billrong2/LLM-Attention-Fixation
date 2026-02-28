#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    nums+=(${nums[@]:(-1)})
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-70 20 9 1") = "-70 20 9 1 1" ]]
}

run_test
