#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[a-zA-Z]+$ ]]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "x") = "true" ]]
}

run_test
