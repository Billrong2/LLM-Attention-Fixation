#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
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
    [[ $(candidate "#284376598") = "false" ]]
}

run_test
