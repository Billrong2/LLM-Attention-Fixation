#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr '[:upper:]' '[:lower:]'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abcDEFGhIJ") = "abcdefghij" ]]
}

run_test
