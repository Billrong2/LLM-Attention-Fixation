#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    echo ${1//$2/$3}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a1a8" "1" "n2") = "an2a8" ]]
}

run_test
