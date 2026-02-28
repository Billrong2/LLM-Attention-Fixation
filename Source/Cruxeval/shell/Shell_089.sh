#!/bin/bash
# $1 is a string
f() {
    if [[ "$1" != *[aeiouAEIOU]* ]]; then
        return
    fi

    if [[ "$1" == [AEIOU]* ]]; then
        echo "$1" | tr '[:upper:]' '[:lower:]'
    else
        echo "$1" | tr '[:lower:]' '[:upper:]'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "o") = "O" ]]
}

run_test
