#!/bin/bash
# $1 is an integer
# $2 is an integer
f() {
    arr=()
    for ((i=0; i<$1; i++)); do
        arr+=($2)
    done
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7" "5") = "5 5 5 5 5 5 5" ]]
}

run_test
