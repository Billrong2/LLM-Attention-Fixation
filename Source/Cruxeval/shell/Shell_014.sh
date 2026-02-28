#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed 's/ *$//' | rev
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "   OOP   ") = "POO" ]]
}

run_test
