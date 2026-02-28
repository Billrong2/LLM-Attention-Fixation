#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    after_place="${1%%$2*}$2"
    before_place="${1#*$2}"
    echo "$after_place$before_place"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "some text" "some") = "some text" ]]
}

run_test
