#!/bin/bash
# $1 is a string
f() {
    [[ $1 == ${1^^} ]] && echo true || echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "VTBAEPJSLGAHINS") = "true" ]]
}

run_test
