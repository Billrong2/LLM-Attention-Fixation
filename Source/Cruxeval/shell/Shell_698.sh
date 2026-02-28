#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr -d ')'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "(((((((((((d))))))))).))))(((((") = "(((((((((((d.(((((" ]]
}

run_test
