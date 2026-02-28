#!/bin/bash
# $1 is a string
f() {
    echo -n $1 | sed 's/ *$//' | rev
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ab        ") = "ba" ]]
}

run_test
