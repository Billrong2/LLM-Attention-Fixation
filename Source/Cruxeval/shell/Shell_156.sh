#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is a string
f() {
    if [ ${#1} -lt $2 ]; then
        printf "%-${2}s\n" "$1"
    else
        printf "%s\n" "${1:0:$2}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "tqzym" "5" "c") = "tqzym" ]]
}

run_test
