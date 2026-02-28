#!/bin/bash
# $1 is a string
f() {
    count=$(echo $1 | tr -cd ':' | wc -c)
    echo $1 | sed "s/:/""/$count"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1::1") = "1:1" ]]
}

run_test
