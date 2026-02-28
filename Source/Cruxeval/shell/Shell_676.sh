#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    echo $1 | sed "s/\t/$(printf '%*s' $2 | tr ' ' ' ')/g"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a" "100") = "a" ]]
}

run_test
