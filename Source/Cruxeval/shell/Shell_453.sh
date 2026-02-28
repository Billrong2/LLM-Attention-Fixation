#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    string=$1
    c=$2
    if [[ "$string" == *"$c" ]]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wrsch)xjmb8" "c") = "false" ]]
}

run_test
