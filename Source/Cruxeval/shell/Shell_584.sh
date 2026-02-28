#!/bin/bash
# $1 is a string
f() {
    printf "%s" "$(printf "$1" "$(printf "%020d" 0)")"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5123807309875480094949830") = "5123807309875480094949830" ]]
}

run_test
