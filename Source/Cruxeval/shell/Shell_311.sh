#!/bin/bash
# $1 is a string
f() {
    text=${1//\#/1}
    text=${text//\$/5}

    if [[ $text =~ ^[0-9]+$ ]]; then
        echo "yes"
    else
        echo "no"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "A") = "no" ]]
}

run_test
