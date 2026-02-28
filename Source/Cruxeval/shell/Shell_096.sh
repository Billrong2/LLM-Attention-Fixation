#!/bin/bash
# $1 is a string
f() {
    [[ $1 =~ [A-Z] ]] && echo false || echo true
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "lunabotics") = "true" ]]
}

run_test
