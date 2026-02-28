#!/bin/bash
# $1 is a space-separated list
f() {
    xs=($1)
    for (( i = -1, j = ${#xs[@]}; i >= -j; i-- )); do
        xs+=(${xs[i]} ${xs[i]})
    done
    echo ${xs[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 8 8 5") = "4 8 8 5 5 5 5 5 5 5 5 5" ]]
}

run_test
