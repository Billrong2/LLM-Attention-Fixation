#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    req=$(( $2 - ${#1} ))
    text=$(printf "%s" "$1" | sed "s/./*/g" | sed "s/.\{$((req/2))\}//")
    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a" "19") = "*" ]]
}

run_test
