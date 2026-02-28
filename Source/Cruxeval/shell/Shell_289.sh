#!/bin/bash
# $1 is a string
f() {
    echo "$1: b'$1'"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "148") = "148: b'148'" ]]
}

run_test
