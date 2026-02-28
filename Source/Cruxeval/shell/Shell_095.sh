#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    echo $1 | awk -F',' '{ print $2 "," $1 }'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "AAA,fr") = "fr,AAA" ]]
}

run_test
