#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    echo $1 | expand -t $2
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a\\tb" "4") = "a\\tb" ]]
}

run_test
