#!/bin/bash
# $1 is a string
f() {
    IFS=',' read -r string_a string_b <<< "$1"
    echo $((-${#string_a} - ${#string_b}))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dog,cat") = "-6" ]]
}

run_test
