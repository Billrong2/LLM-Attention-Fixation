#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo $(echo $1 | tr -cd '[:digit:]')
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "816") = "816" ]]
}

run_test
