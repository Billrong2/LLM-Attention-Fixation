#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    [[ $1 =~ ^[a-z]+$ && $2 =~ ^[a-z]+$ ]] && echo true || echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abc" "e") = "true" ]]
}

run_test
