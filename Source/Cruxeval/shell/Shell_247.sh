#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[a-zA-Z]+$ ]]; then
        echo "yes"
    elif [[ -z $1 ]]; then
        echo "str is empty"
    else
        echo "no"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Boolean") = "yes" ]]
}

run_test
