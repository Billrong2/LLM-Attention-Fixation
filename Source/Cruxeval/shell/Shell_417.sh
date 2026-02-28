#!/bin/bash
# $1 is a space-separated list
f() {
    set -- $(echo $1 | tr " " "\n" | tail -n +2)
    echo $*
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7 8 2 8") = "8 2 8" ]]
}

run_test
