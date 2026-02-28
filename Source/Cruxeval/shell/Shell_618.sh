#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    echo "${2:0:$3}${1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "9" "8" "2") = "89" ]]
}

run_test
