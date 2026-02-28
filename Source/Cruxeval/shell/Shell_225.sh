#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ [^a-z] ]]; then
        echo false
    else
        echo true
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "54882") = "false" ]]
}

run_test
