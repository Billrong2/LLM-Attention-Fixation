#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$(echo "$1" | tr '\n' '_____')
    text=$(echo "$text" | sed "s/\t/$(printf "%${2}s")/g")
    text=$(echo "$text" | tr '_____' '\n')
    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "odes	code	well" "2") = "odes  code  well" ]]
}

run_test
