#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[[:alnum:]]+$ ]]; then
        echo "True"
    else
        echo "False"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "777") = "True" ]]
}

run_test
