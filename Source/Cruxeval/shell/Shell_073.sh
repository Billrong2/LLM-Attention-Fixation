#!/bin/bash
# $1 is a string
f() {
    ones=$(grep -o '1' <<< "$1" | wc -l)
    zeros=$(grep -o '0' <<< "$1" | wc -l)
    echo "$ones $zeros"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "100010010") = "3 6" ]]
}

run_test
