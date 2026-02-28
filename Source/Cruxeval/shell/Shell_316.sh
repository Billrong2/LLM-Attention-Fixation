#!/bin/bash
# $1 is a string
f() {
    echo "| $(echo $1 | tr ' ' '\n' | paste -sd ' ') |"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "i am your father") = "| i am your father |" ]]
}

run_test
