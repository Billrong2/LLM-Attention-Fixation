#!/bin/bash
# $1 is a space-separated list
f() {
    set -f
    nums=($1)
    nums=()
    echo "quack"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 5 1 7 9 3") = "quack" ]]
}

run_test
