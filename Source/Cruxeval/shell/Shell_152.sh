#!/bin/bash
# $1 is a string
f() {
    echo $1 | grep -o '[A-Z]' | wc -l
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "AAAAAAAAAAAAAAAAAAAA") = "20" ]]
}

run_test
