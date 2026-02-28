#!/bin/bash
# $1 is a string
f() {
    echo $1 | grep -o [0-9] | wc -l
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "so456") = "3" ]]
}

run_test
