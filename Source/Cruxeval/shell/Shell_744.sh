#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    echo "$1$2"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jro" "wdlp") = "jrowdlp" ]]
}

run_test
