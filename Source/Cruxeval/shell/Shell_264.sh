#!/bin/bash
# $1 is a string
f() {
    s=${1//a/A}
    echo ${s//e/A}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "papera") = "pApArA" ]]
}

run_test
