#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    text=$1
    space_symbol=$2
    size=$3

    spaces=$(printf "%0.s$space_symbol" $(seq 1 $((size - ${#text}))))
    echo "$text$spaces"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "w" "))" "7") = "w))))))))))))" ]]
}

run_test
