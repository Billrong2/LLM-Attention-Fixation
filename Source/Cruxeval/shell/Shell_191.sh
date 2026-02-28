#!/bin/bash
# $1 is a string
f() {
    string="$1"
    if [[ $string =~ ^[A-Z]+$ ]]; then
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
    [[ $(candidate "Ohno") = "false" ]]
}

run_test
