#!/bin/bash
# $1 is a string
f() {
    new_text=$1
    while [[ ${#1} -gt 1 && ${1:0:1} == ${1: -1} ]]; do
        new_text=${1:1: -1}
    done
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ")") = ")" ]]
}

run_test
