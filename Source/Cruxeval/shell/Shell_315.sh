#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr '[:upper:]' '[:lower:]' | tr 'l' ','
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "czywZ") = "czywz" ]]
}

run_test
