#!/bin/bash
# $1 is a string
f() {
    [[ $1 = *[^0-9]* ]] && echo true || echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "the speed is -36 miles per hour") = "true" ]]
}

run_test
