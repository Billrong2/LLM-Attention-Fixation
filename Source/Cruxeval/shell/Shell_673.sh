#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == ${1^^} ]]; then
        echo $1 | tr '[:upper:]' '[:lower:]'
    elif [[ $1 == ${1,,} ]]; then
        echo $1 | tr '[:lower:]' '[:upper:]'
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "cA") = "cA" ]]
}

run_test
