#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    width=$(($2 > 0 ? $2 : 1))
    printf "%0${width}d\n" $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "19" "5") = "00019" ]]
}

run_test
