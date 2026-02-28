#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text="$1"
    value="$2"
    len=${#value}
    printf "%s" "$text"
    for ((i=0; i<$(($len - ${#text})); i++)); do
        printf "?"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "\!?" "") = "\!?" ]]
}

run_test
