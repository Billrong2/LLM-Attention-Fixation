#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    case "$1" in
        "$2"*) echo true;;
        *) echo false;;
    esac
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hello world" "Hello") = "true" ]]
}

run_test
