#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo 'yes'
    else
        echo 'no'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abc") = "no" ]]
}

run_test
