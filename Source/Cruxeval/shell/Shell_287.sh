#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == ${1,,} ]]; then
        echo ${1^^}
    else
        echo ${1,,}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Pinneaple") = "pinneaple" ]]
}

run_test
