#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    printf "%0.sz" $(seq 1 $(( $2 - ${#1} ))) && echo $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abc" "8") = "zzzzzabc" ]]
}

run_test
