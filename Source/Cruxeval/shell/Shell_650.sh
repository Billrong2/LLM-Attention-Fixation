#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    while [[ $1 == $2* ]]; do
        string=${1#$2}
    done
    echo $string
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "A") = "" ]]
}

run_test
