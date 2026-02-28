#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo "integer"
    else
        echo "string"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "string" ]]
}

run_test
