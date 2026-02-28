#!/bin/bash
# $1 is a string
f() {
    rev=""
    for (( i=${#1}-1; i>=0; i-- )); do
        rev="${rev}${1:$i:1}"
    done
    echo $rev
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "crew") = "werc" ]]
}

run_test
