#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed 's/\\"/"/g'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Because it intrigues them") = "Because it intrigues them" ]]
}

run_test
