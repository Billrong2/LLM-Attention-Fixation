#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr "\"'><" "9833"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Transform quotations\"\nnot into numbers.") = "Transform quotations9\nnot into numbers." ]]
}

run_test
