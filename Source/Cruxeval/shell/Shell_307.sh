#!/bin/bash
# $1 is a string
f() {
    rtext=$1
    for i in $(seq 1 $(( ${#rtext} - 2 ))); do
        rtext="${rtext:0:i+1}|${rtext:i+1}"
    done
    echo $rtext
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "pxcznyf") = "px|||||cznyf" ]]
}

run_test
