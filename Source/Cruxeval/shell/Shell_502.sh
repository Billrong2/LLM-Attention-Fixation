#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr ' ' '*'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Fred Smith") = "Fred*Smith" ]]
}

run_test
