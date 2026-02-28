#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    reversed_nums=($(echo "${nums[@]}" | tr ' ' '\n' | tac))
    echo "${reversed_nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-6 -2 1 -3 0 1") = "1 0 -3 1 -2 -6" ]]
}

run_test
