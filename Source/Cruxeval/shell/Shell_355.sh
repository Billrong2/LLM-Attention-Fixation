#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    prefix=$2
    echo "${text:${#prefix}}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "123x John z" "z") = "23x John z" ]]
}

run_test
