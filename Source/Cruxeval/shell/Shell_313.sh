#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    local result=$(printf "%-${2}s" "$1" | tr ' ' '=')
    echo "${result%=*}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "urecord" "8") = "urecord" ]]
}

run_test
