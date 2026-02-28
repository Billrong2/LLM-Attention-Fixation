#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for ((i=0; i<${#nums[@]}-1; i++)); do
        nums=($(echo "${nums[@]}" | rev))
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 -9 7 2 6 -3 3") = "1 -9 7 2 6 -3 3" ]]
}

run_test
