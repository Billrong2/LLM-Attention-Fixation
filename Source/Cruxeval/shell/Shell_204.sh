#!/bin/bash
# $1 is a string
f() {
    first_char="${1:0:1}"
    second_char_reversed="${1:1:1}"
    echo "$first_char $second_char_reversed"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "master. ") = "m a" ]]
}

run_test
