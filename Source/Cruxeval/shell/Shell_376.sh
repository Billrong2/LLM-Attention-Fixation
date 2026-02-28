#!/bin/bash
# $1 is a string
f() {
    len=${#1}
    for (( i=0; i<$len; i++ )); do
        if [[ "${1:0:i}" == "two" ]]; then
            echo "${1:i}"
            return
        fi
    done
    echo 'no'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2two programmers") = "no" ]]
}

run_test
