#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    result=($1)
    if [ $2 -ne 0 ]; then
        result=($(echo ${result[@]} | tr ' ' '\n' | tac))
    fi
    echo ${result[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4" "1") = "4 3 2 1" ]]
}

run_test
