#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr -d 'a' | tr -d 'r'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "rpaar") = "p" ]]
}

run_test
