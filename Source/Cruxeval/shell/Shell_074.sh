#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    lst=($1)
    i=$2
    n=$3
    lst=("${lst[@]:0:i}" "$n" "${lst[@]:i}")
    echo "${lst[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "44 34 23 82 24 11 63 99" "4" "15") = "44 34 23 82 15 24 11 63 99" ]]
}

run_test
