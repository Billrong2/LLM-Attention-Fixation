#!/bin/bash
# $1 is a space-separated list
f() {
    echo $1 | tr ' ' '\n' | tac | paste -sd ' '
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 0 1 9999 3 -5") = "-5 3 9999 1 0 2" ]]
}

run_test
