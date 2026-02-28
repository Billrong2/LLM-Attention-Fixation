#!/bin/bash
# $1 is a space-separated list
f() {
    sales=($1)
    while [ ${#sales[@]} -ne 1 ]; do
        val=${sales[0]}
        sales=("${sales[@]:1}")
        sales+=($val)
    done
    echo ${sales[0]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6") = "6" ]]
}

run_test
